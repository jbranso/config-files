;;; modal-mode.el --- modal editing framework

;; Copyright (C) 2009  John J Foerch <jjfoerch@earthlink.net>

;; Author: John J Foerch <jjfoerch@earthlink.net>
;; Time-stamp: <2010-04-26 16:00:22 jjf>

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 2
;; of the License, or (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
;; 02110-1301, USA.

;;; Commentary:
;;;
;;;   Modal-mode is an effort to provide modal editing to Emacs, but
;;; remain light, and not step too far into the territory of Vi
;;; emulation.  Its default bindings are based on Vi, but its design
;;; accomodates the creation of other modality styles.  It has
;;; explicit support for Vi-like text-objects through transient modes
;;; that turn movement keys into selection keys in order to provide
;;; compound commands like those of Vi's d, y, and c keys.
;;;
;;;
;;; Glossary:
;;;
;;;  primary modal: one of a group of mutually exclusive minor modes
;;;      providing a set of key bindings and/or behaviors.
;;;      modal-cmd-mode and modal-ins-mode are examples of primary
;;;      modals.  Only one can be enabled at a time in a given buffer.
;;;
;;;  secondary modal: an auxiliary minor mode that provides additional
;;;      functionality to a primary modal.  modal-1off-kill-mode is an
;;;      example of a secondary modal.
;;;
;;;
;;; Installation:
;;;
;;;   Put this file (and/or a byte-compiled version of it) in a
;;; directory in your emacs load-path and put code like the following
;;; in your .emacs.
;;;
;;;   ;;; Modal-mode setup
;;;   ;;;
;;;   (require 'modal-mode)
;;;   (setq default-major-mode 'modal-fundamental-mode)
;;;   (modal-mode 1)
;;;   (when window-system
;;;     (modal-mode-line-background-mode 1))
;;;   ;;;
;;;   ;;; end modal-mode setup
;;;
;;;
;;; Problems:
;;;
;;;  * Globalized minor-modes do not see newly created
;;;    fundamental-mode buffers.
;;;
;;;  * If you do an isearch in modal-cmd-mode, and switch input methods in
;;;    the isearch, the input method remains in effect in modal-cmd-mode
;;;    after isearch has exited.
;;;
;;;  * Conflicts with yas/snippet.  ESC fails to work in modal-ins-mode
;;;    because yas/snippet also has an intercept keymap.
;;;

;;; Code:

;;;;
;;;; MODAL MODE
;;;;

(defvar modal-string 'modal-current
  "Mode-line construct to show current modal in mode-line.  It
should contain 'modal-current.  Refer to `mode-line-format' for
an explanation of mode-line constructs.")
(put 'modal-string 'risky-local-variable t)

(defvar modal-current nil
  "Internal variable holding a string which indicates the current
modal for the buffer.  This is used in modal-string to show the
current modal in the mode-line.")
(put 'modal-current 'risky-local-variable t)
(make-variable-buffer-local 'modal-current)

(defvar modal-modes-list ()
  "Internal registry of primary modals.  Used to make sure only
one modal is enabled at a time.")

(defvar modal-local-whitelist nil
  "Internal variable.  Holds an alist structure, mapping modals
to lists of major modes.  The modal will be automatically enabled
in all of the major modes associated with it.  This structure is
set by modality systems, like modal-vilike-mode.")

(defvar modal-local-derived-whitelist nil
  "Internal variable.  Holds an alist structure, mapping modals
to lists of major modes.  The modal will be automatically enabled
in all major modes that are derived from a mode in the list.
This structure is set by modality systems, like
modal-vilike-mode.")


;;; Utilities
;;;

(defun modal-find (pred lst)
  "Return the first item in LST for which PRED is non-nil."
  (let (found)
    (while (and lst (not found))
      (when (funcall pred (car lst))
        (setq found (car lst)))
      (setq lst (cdr lst)))
    found))

(defun modal-local-find-in-whitelists ()
  "Find a modal for the current major mode in
modal-local-whitelist or modal-local-derived-whitelist."
  (car
   (or
    (modal-find
     (lambda (x) (memq major-mode (cdr x)))
     modal-local-whitelist)
    (modal-find
     (lambda (x) (apply 'derived-mode-p (cdr x)))
     modal-local-derived-whitelist))))

(defun modal-add-to-mode-line-construct (var &optional force-nil)
  "Add the modal-string indicator to a mode-line construct.  Give
the mode-line construct VAR as a symbol.  If FORCE-NIL is given,
the mode-line construct will be set even if the given var is
nil."
  (let ((val (symbol-value var)))
    (cond
     ((null val)
      (when force-nil
	(set var 'modal-string)))
     ((or (symbolp val)
	  (and (consp val)
	       (or (symbolp (car val))
		   (numberp (car val)))))
      (set var (list "" val 'modal-string)))
     ((stringp val)
      (set var (list val 'modal-string)))
     ((and (consp val) (stringp (car val)))
      (let ((last (car (last val))))
	(if (and (stringp last) (>= (length last) 2)
		 (equal "%-" (substring last -2)))
	    (set var (append (butlast val) '(modal-string) (last val)))
	  (set var (append val '(modal-string)))))))))

(defun modal-remove-from-mode-line-construct (var)
  "Remove the modal-string indicator from the mode-line construct
variable VAR.  The variable must be given as a symbol."
  (let ((val (symbol-value var)))
    (cond
     ((eq 'modal-string val)
      (set var nil))
     ((consp val)
      (set var nil)
      (mapc
       (lambda (x)
	 (unless (eq 'modal-string x)
	   (push x var)))
       (nreverse val))))))

(defun modal-disable-others (current)
  "Disable all modals listed in `modal-modes-list' except
for CURRENT."
  (mapc
   (lambda (m)
     (unless (eq m current)
       (funcall m -1)))
   modal-modes-list))


;;; modal-local-mode, modal-globalized-mode
;;;
;;;   modal-local-mode manages the mutually exclusive modals within a
;;; single buffer.  modal-globalized-mode turns on modal-local-mode in
;;; all possible and applicable buffers.
;;;

(define-minor-mode modal-local-mode
  "Minor mode that ensures modal-mode is correctly disabled by
disabling all primary modals in the given buffer."
  nil nil nil
  (unless modal-local-mode
    (modal-disable-others nil)
    (setq modal-current nil)))

(defun modal-local-mode-enable ()
  (unless (minibufferp)
    (let ((modal (modal-local-find-in-whitelists)))
      (when modal
        (modal-local-mode 1)
        (funcall modal 1)))))

(define-globalized-minor-mode modal-globalized-mode
  modal-local-mode modal-local-mode-enable)


;;; modal-mode
;;;
;;;   modal-mode itself is a global minor mode that handles special
;;; keymaps, mode-line status notifiers, and turning on
;;; modal-globalized-mode.
;;;

(defvar modal-system nil)

(defvar modal-intercept-keymaps ()
  "A structure for emulation-mode-map-alists to which modals can
add their own intercept keymaps.  These are typically used to
override the escape key.")

(define-minor-mode modal-mode
  ""
  nil nil nil
  :global t
  (cond
   (modal-mode
    (modal-add-to-mode-line-construct 'global-mode-string t)
    (add-hook 'emulation-mode-map-alists 'modal-intercept-keymaps)
    (funcall modal-system 1)
    (modal-globalized-mode 1))
   (t
    (modal-remove-from-mode-line-construct 'global-mode-string)
    (remove-hook 'emulation-mode-map-alists 'modal-intercept-keymaps)
    (modal-globalized-mode -1)
    (funcall modal-system -1))))

;;;;
;;;; MODALITY SYSTEMS
;;;;

;;; commands
;;;
;;;   Some basic commands.
;;;

(defun modal-ding ()
  "Ding the bell."
  (interactive)
  (ding))

(defun modal-move-to-first-char ()
  "Move point to the first non-blank character on the line.
Returns point for convenience."
  (interactive)
  (move-beginning-of-line nil)
  (when (looking-at "\\s-*")
    (forward-char (length (match-string 0))))
  (point))

(defun modal-move-to-window-top ()
  "Move point to the beginning of the top line of the window.
Returns point for convenience."
  (interactive)
  (move-to-window-line 0)
  (point))

(defun modal-move-to-window-middle ()
  "Move point to the beginning of the middle line of the window.
Returns point for convenience."
  (interactive)
  (move-to-window-line nil)
  (point))

(defun modal-move-to-window-bottom ()
  "Move point to the beginning of the bottom line of the window.
Returns point for convenience."
  (interactive)
  (move-to-window-line -1)
  (point))

;;; modal-text-object-mode
;;;
;;;   A minor mode that remaps movement commands to text-object
;;; selection commands, a-la vi.
;;;

(defvar modal-text-object nil
  "Internal variable for holding the stack of text objects.")
(make-variable-buffer-local 'modal-text-object)

(defvar modal-text-object-mode-map (make-sparse-keymap))
(mapc
 (lambda (x) (define-key modal-text-object-mode-map (eval (car x)) (cdr x)))
 '(([remap move-beginning-of-line] . modal-text-object-to-beginning-of-line)
   ([remap modal-move-to-first-char] . modal-text-object-to-first-char)
   ([remap move-end-of-line] . modal-text-object-to-end-of-line)
   ([remap next-line] . modal-text-object-lines-down)
   ([remap previous-line] . modal-text-object-lines-up)
   ([remap forward-char] . modal-text-object-forward-char)
   ([remap backward-char] . modal-text-object-backward-char)
   ([remap forward-word] . modal-text-object-forward-word)
   ([remap backward-word] . modal-text-object-backward-word)
   ([remap forward-sentence] . modal-text-object-forward-sentence)
   ([remap backward-sentence] . modal-text-object-backward-sentence)
   ([remap forward-paragraph] . modal-text-object-forward-paragraph)
   ([remap backward-paragraph] . modal-text-object-backward-paragraph)
   ([remap modal-move-to-window-top] . modal-text-object-to-window-top)
   ([remap modal-move-to-window-middle] . modal-text-object-to-window-middle)
   ([remap modal-move-to-window-bottom] . modal-text-object-to-window-bottom)
   ([remap jump-to-register] . modal-text-object-jump-to-register)))

(defun modal-text-object-to-beginning-of-line (&optional arg)
  (interactive "p")
  (push
   (list (point-at-bol
          (cond ((> arg 1) (- (- arg 2)))
                ((< arg 1) (+ (- arg) 1))
                (t arg)))
         (point))
   modal-text-object))

(defun modal-text-object-to-first-char (&optional arg)
  (interactive "p")
  (push
   (list (point) (save-excursion (modal-move-to-first-char)))
   modal-text-object))

(defun modal-text-object-to-end-of-line (&optional arg)
  (interactive "p")
  (push
   (list (point) (point-at-eol arg))
   modal-text-object))

(defun modal-text-object-whole-line (&optional arg)
  (interactive "p")
  (push
   (list (point-at-bol)
         (save-excursion
           (goto-char (point-at-eol arg))
           (unless (eobp)
             (forward-char))
           (point)))
   modal-text-object))

(defun modal-text-object-lines-down (&optional arg)
  (interactive "p")
  (push
   (list (point-at-bol)
         (point-at-bol (+ 2 arg)))
   modal-text-object))

(defun modal-text-object-lines-up (&optional arg)
  (interactive "p")
  (push
   (list (point-at-bol 2)
         (point-at-bol (- (1- arg))))
   modal-text-object))

(defun modal-text-object-forward-char (&optional arg)
  (interactive "p")
  (push (list (point) (+ (point) arg)) modal-text-object))

(defun modal-text-object-backward-char (&optional arg)
  (interactive "p")
  (push (list (- (point) arg) (point)) modal-text-object))

(defun modal-text-object-forward-word (&optional arg)
  (interactive "p")
  (push (list (point)
              (save-excursion
                (forward-word arg)
                (point)))
        modal-text-object))

(defun modal-text-object-backward-word (&optional arg)
  (interactive "p")
  (push (list (point)
              (save-excursion
                (backward-word arg)
                (point)))
        modal-text-object))

(defun modal-text-object-forward-sentence (&optional arg)
  (interactive "p")
  (push (list (point)
              (save-excursion
                (forward-sentence arg)
                (point)))
        modal-text-object))

(defun modal-text-object-backward-sentence (&optional arg)
  (interactive "p")
  (push (list (point)
              (save-excursion
                (backward-sentence arg)
                (point)))
        modal-text-object))

(defun modal-text-object-forward-paragraph (&optional arg)
  (interactive "p")
  (push (list (point)
              (save-excursion
                (forward-paragraph arg)
                (point)))
        modal-text-object))

(defun modal-text-object-backward-paragraph (&optional arg)
  (interactive "p")
  (push (list (point)
              (save-excursion
                (backward-paragraph arg)
                (point)))
        modal-text-object))

(defun modal-text-object-to-window-top ()
  (interactive)
  (push (list (point-at-bol 2)
              (save-excursion
                (modal-move-to-window-top)))
        modal-text-object))

(defun modal-text-object-to-window-middle ()
  (interactive)
  (let ((mid (save-excursion
               (modal-move-to-window-middle))))
    (push (list mid
                (point-at-bol
                 (if (> (point) mid) 2)))
          modal-text-object)))

(defun modal-text-object-to-window-bottom ()
  (interactive)
  (push (list (point-at-bol)
              (save-excursion
                (modal-move-to-window-bottom)
                (point-at-bol 2)))
        modal-text-object))

(defun modal-text-object-jump-to-register (register)
  (interactive "cJump to register: ")
  (push (list (point)
              (save-excursion
                (jump-to-register register)
                (point)))
        modal-text-object))


(define-minor-mode modal-text-object-mode
  "A minor mode that remaps movement commands to text-object
 selection commands, a-la vi."
  nil nil modal-text-object-mode-map
  (setq modal-text-object nil))


;;; modal-text-object-two-mode
;;;
;;;   A minor mode that remaps movement commands to text-object
;;; selection commands which find two text-objects.
;;;

(defvar modal-text-object-two-mode-map (make-sparse-keymap))
(mapc
 (lambda (x) (define-key modal-text-object-two-mode-map (eval (car x)) (cdr x)))
 '(([remap next-line] . modal-text-object-two-lines-down)
   ([remap previous-line] . modal-text-object-two-lines-up)
   ([remap backward-char] . modal-text-object-two-backward-char)
   ([remap forward-char] . modal-text-object-two-forward-char)))

(defun modal-text-object-two-lines-down (&optional arg)
  (interactive "p")
  (save-excursion
    (push
     (list (point-at-bol)
           (progn
             (goto-char (point-at-eol 1))
             (unless (eobp)
               (forward-char))
             (point)))
     modal-text-object)
    (push
     (list (point)
           (progn
             (goto-char (point-at-eol 1))
             (unless (eobp)
               (forward-char))
             (point)))
     modal-text-object)))

(defun modal-text-object-two-lines-up (&optional arg)
  (interactive "p")
  (save-excursion
    (push
     (list (progn
             (forward-line -1)
             (point))
           (progn
             (goto-char (point-at-eol 1))
             (forward-char)
             (point)))
     modal-text-object)
    (push
     (list (point)
           (progn
             (goto-char (point-at-eol 1))
             (unless (eobp)
               (forward-char))
             (point)))
     modal-text-object)))

(defun modal-text-object-two-backward-char (&optional arg)
  (interactive "p")
  (push (list (point) (+ (point) 1)) modal-text-object)
  (push (list (- (point) 1) (point)) modal-text-object))

(defun modal-text-object-two-forward-char (&optional arg)
  (interactive "p")
  (push (list (point) (+ (point) 1)) modal-text-object)
  (push (list (+ (point) 1) (+ (point) 2)) modal-text-object))

(define-minor-mode modal-text-object-two-mode
  "A minor mode that remaps movement commands to text-object
 selection commands, a-la vi."
  nil nil modal-text-object-two-mode-map
  (setq modal-text-object nil))


;;; modal-1off-kill-mode
;;;
;;;   This is a secondary (non-exclusive) modal which makes a single
;;; movement key into a kill key.  It disables itself after one
;;; command, excepting the universal-argument commands.
;;;

(defvar modal-1off-kill-mode-map (make-sparse-keymap))
(mapc
 (lambda (x) (define-key modal-1off-kill-mode-map (eval (car x)) (cdr x)))
 '(([remap modal-1off-kill-mode-enable] . modal-text-object-whole-line)))

(defun modal-1off-kill-mode-enable ()
  (interactive)
  (modal-1off-kill-mode 1))

(defun modal-1off-kill-mode-disable-maybe ()
  (unless
      (memq this-command
            '(modal-1off-kill-mode-enable
              digit-argument
              negative-argument
              universal-argument
              universal-argument-other-key))
    (unwind-protect
	(when modal-text-object
	  (apply 'kill-region (pop modal-text-object)))
      (modal-1off-kill-mode -1))))

(define-minor-mode modal-1off-kill-mode
  "a mode in which unmodified characters are bound to various
kill commands."
  nil nil modal-1off-kill-mode-map
  (cond
   (modal-1off-kill-mode
    (modal-text-object-mode 1)
    (add-hook 'post-command-hook 'modal-1off-kill-mode-disable-maybe nil t)
    (message "kill..."))
   (t
    (modal-text-object-mode -1)
    (remove-hook 'post-command-hook 'modal-1off-kill-mode-disable-maybe t))))


;;; modal-1off-copy-mode
;;;
;;;   This is a secondary (non-exclusive) modal which makes a single
;;; movement key into a copy key.  It disables itself after one
;;; command, excepting the universal-argument commands.
;;;

(defvar modal-1off-copy-mode-map (make-sparse-keymap))
(mapc
 (lambda (x) (define-key modal-1off-copy-mode-map (eval (car x)) (cdr x)))
 '(([remap modal-1off-copy-mode-enable] . modal-text-object-whole-line)))

(defun modal-1off-copy-mode-enable ()
  (interactive)
  (modal-1off-copy-mode 1))

(defun modal-1off-copy-mode-disable-maybe ()
  (unless
      (memq this-command
            '(modal-1off-copy-mode-enable
              digit-argument
              negative-argument
              universal-argument
              universal-argument-other-key))
    (unwind-protect
	(let ((ob (pop modal-text-object)))
	  (when ob
	    (apply 'copy-region-as-kill ob)
	    (message "Saved %s characters" (abs (apply '- ob)))))
      (modal-1off-copy-mode -1))))

(define-minor-mode modal-1off-copy-mode
  "a mode in which unmodified characters are bound to various
copy commands."
  nil nil modal-1off-copy-mode-map
  (cond
   (modal-1off-copy-mode
    (modal-text-object-mode 1)
    (add-hook 'post-command-hook 'modal-1off-copy-mode-disable-maybe nil t)
    (message "copy..."))
   (t
    (modal-text-object-mode -1)
    (remove-hook 'post-command-hook 'modal-1off-copy-mode-disable-maybe t))))


;;; modal-1off-change-mode
;;;
;;;   This is a secondary (non-exclusive) modal which makes a single
;;; movement key into a change key.  It disables itself after one
;;; command, excepting the universal-argument commands.
;;;

(defvar modal-1off-change-mode-map (make-sparse-keymap))
(mapc
 (lambda (x) (define-key modal-1off-change-mode-map (eval (car x)) (cdr x)))
 '(([remap modal-1off-change-mode-enable] . modal-text-object-whole-line)))

(defun modal-1off-change-mode-enable ()
  (interactive)
  (modal-1off-change-mode 1))

(defun modal-1off-change-mode-disable-maybe ()
  (unless
      (memq this-command
            '(modal-1off-change-mode-enable
              digit-argument
              negative-argument
              universal-argument
              universal-argument-other-key))
    (unwind-protect
	(when modal-text-object
	  (apply 'delete-region (pop modal-text-object))
	  (modal-ins-mode-enable))
      (modal-1off-change-mode -1))))

(define-minor-mode modal-1off-change-mode
  "a mode in which unmodified characters are bound to various
change commands."
  nil nil modal-1off-change-mode-map
  (cond
   (modal-1off-change-mode
    (modal-text-object-mode 1)
    (add-hook 'post-command-hook 'modal-1off-change-mode-disable-maybe nil t)
    (message "change..."))
   (t
    (modal-text-object-mode -1)
    (remove-hook 'post-command-hook 'modal-1off-change-mode-disable-maybe t))))


;;; modal-1off-transpose-mode
;;;
;;;   A text-object action that transposes two text objects.
;;;

(defvar modal-1off-transpose-mode-map (make-sparse-keymap))
(mapc
 (lambda (x) (define-key modal-1off-transpose-mode-map (eval (car x)) (cdr x)))
 '(([remap modal-1off-transpose-mode-enable] . modal-text-object-two-lines-down)))

(defun modal-1off-transpose-mode-enable ()
  (interactive)
  (modal-1off-transpose-mode 1))

(defun modal-1off-transpose-mode-disable-maybe ()
  (unless
      (memq this-command
            '(modal-1off-transpose-mode-enable
              digit-argument
              negative-argument
              universal-argument
              universal-argument-other-key))
    ;; check for read-only somewhere, so we can have an intelligible
    ;; error message?
    (unwind-protect
	(when modal-text-object
	  (apply 'transpose-regions
		 (append (pop modal-text-object)
			 (pop modal-text-object))))
      (modal-1off-transpose-mode -1))))

(define-minor-mode modal-1off-transpose-mode
  "a mode in which unmodified characters are bound to various
transpose commands."
  nil nil modal-1off-transpose-mode-map
  (cond
   (modal-1off-transpose-mode
    (modal-text-object-two-mode 1)
    (add-hook 'post-command-hook 'modal-1off-transpose-mode-disable-maybe nil t)
    (message "transpose..."))
   (t
    (modal-text-object-two-mode -1)
    (remove-hook 'post-command-hook 'modal-1off-transpose-mode-disable-maybe t))))


;;; modal-cmd-mode
;;;
;;;   This is a primary modal like vi's command mode.
;;;

(defvar modal-cmd-intercept-map (make-sparse-keymap))
(mapc
 (lambda (x) (define-key modal-cmd-intercept-map (eval (car x)) (cdr x)))
 `(([remap self-insert-command] . modal-ding)
   ([remap toggle-input-method] . modal-ding)

   ((kbd "1") . digit-argument)
   ((kbd "2") . digit-argument)
   ((kbd "3") . digit-argument)
   ((kbd "4") . digit-argument)
   ((kbd "5") . digit-argument)
   ((kbd "6") . digit-argument)
   ((kbd "7") . digit-argument)
   ((kbd "8") . digit-argument)
   ((kbd "9") . digit-argument)
   ((kbd "a") . move-beginning-of-line)

   ((kbd "u") . move-end-of-line)
   ((kbd "^") . modal-move-to-first-char)
   ((kbd "(") . backward-sentence)
   ((kbd ")") . forward-sentence)

   ((kbd "q") . bury-buffer)
   ((kbd "s") . forward-word)
   ((kbd "r") . modal-cmd-replace-char)
   ((kbd "t") . modal-1off-transpose-mode-enable)
   ((kbd "y") . modal-1off-copy-mode-enable)
   ((kbd "v") . scroll-down)
   ((kbd "i") . modal-ins-mode-enable)
   ((kbd "o") . modal-ins-mode-enable-open-down)

   ((kbd "Q") . unbury-buffer)
   ((kbd "I") . modal-ins-mode-enable-first-char)
   ((kbd "O") . modal-ins-mode-enable-open-up)
   ((kbd "P") . yank)

   ((kbd "a") . modal-ins-mode-enable-next-char)
   ((kbd "d") . modal-1off-kill-mode-enable)
   ((kbd "n") . backward-char)
   ((kbd "h") . next-line)
   ((kbd "t") . previous-line)
   ((kbd "s") . forward-char)
   ((kbd "'") . jump-to-register)

   ((kbd "A") . modal-ins-mode-enable-eol)
   ((kbd "D") . kill-line)
   ((kbd "G") . goto-line)
   ((kbd "H") . modal-move-to-window-top)
   ((kbd "J") . join-line)
   ((kbd "L") . modal-move-to-window-bottom)

   ((kbd "x") . delete-char)
   ((kbd "c") . modal-1off-change-mode-enable)
   ((kbd "o") . backward-word)
   ((kbd "m") . point-to-register)

   ((kbd "X") . backward-delete-char-untabify)
   ((kbd "M") . execute-extended-command)

   ((kbd "V") . scroll-up)

   ((kbd "{") . backward-paragraph)
   ((kbd "}") . forward-paragraph)

   ([remap newline] . next-line)
   ((kbd "ESC") . modal-cmd-handle-escape)))

(defun modal-cmd-handle-escape ()
  (interactive)
  (let ((event last-input-event)
        (ESC-keys '(?\e (control \[) escape)))
    (if (sit-for (/ (if window-system 0 200) 1000.0) t)
        (modal-ding)
      ;; otherwise we somehow need to unread the event or otherwise
      ;; let emacs handle it as normal---i.e., bypass this intercept
      (let (emulation-mode-map-alists)
	(setq unread-command-events
	      (list (cons t event)))
	(call-interactively (key-binding (read-key-sequence nil t)))))))

(defvar modal-cmd-string (propertize "<C>" 'face 'hi-blue-b)
  "Mode-line string for modal-cmd-mode.")

(defvar modal-cmd-cursor-type 'box
  "Cursor type for modal-cmd-mode.  See cursor-type for allowed
values.")

(defvar modal-cmd-mode-hook ()
  "Hook run when modal-cmd-mode is enabled.")

(defvar modal-cmd-input-method nil)
(make-variable-buffer-local 'modal-cmd-input-method)

(defun modal-cmd-replace-char (replacement)
  "Prompt for replacement, and replace character at point."
  (interactive "cReplacement?")
  (delete-char 1)
  (save-excursion (insert (char-to-string replacement))))

(defun modal-cmd-mode-enable ()
  "Command to enable modal-cmd-mode."
  (interactive)
  (modal-cmd-mode 1))

(define-minor-mode modal-cmd-mode
  "a mode in which unmodified characters are bound to various
commands."
  nil nil nil
  (cond
   (modal-cmd-mode
    (modal-disable-others 'modal-cmd-mode)
    (setq modal-cmd-input-method current-input-method)
    (when current-input-method
      (inactivate-input-method))
    (setq modal-current modal-cmd-string)
    (force-mode-line-update)
    (setq cursor-type modal-cmd-cursor-type)
    (run-hooks 'modal-cmd-mode-hook))
   (t
    (when modal-cmd-input-method
      (activate-input-method modal-cmd-input-method)
      (setq modal-cmd-input-method nil)))))

(add-to-list
 'modal-intercept-keymaps
 `(modal-cmd-mode . ,modal-cmd-intercept-map))

(add-hook 'modal-modes-list 'modal-cmd-mode)


;;; modal-ins-mode
;;;
;;;   This is a primary modal for normal typing.  The ESC key exits
;;; the mode and enables cmd-mode.
;;;

(defun modal-ins-handle-escape ()
  (interactive)
  (let ((event last-input-event)
        (ESC-keys '(?\e (control \[) escape)))
    (if (sit-for (/ (if window-system 0 200) 1000.0) t)
        (modal-cmd-mode)
      ;; otherwise we somehow need to unread the event or otherwise
      ;; let emacs handle it as normal---i.e., bypass this intercept
      (let (emulation-mode-map-alists)
	(setq unread-command-events
	      (list (cons t event)))
	(call-interactively (key-binding (read-key-sequence nil t)))))))

(defvar modal-ins-intercept-map (make-sparse-keymap))
(define-key modal-ins-intercept-map (kbd "ESC") 'modal-ins-handle-escape)

(defvar modal-ins-string (propertize "<I>" 'face 'hi-red-b)
  "Mode-line string for modal-ins-mode")

(defvar modal-ins-cursor-type 'bar
  "Cursor type for modal-ins-mode.  See cursor-type for allowed
values.")

(defvar modal-ins-mode-hook ()
  "A hook run when modal-ins-mode is enabled.")

(defun modal-ins-mode-enable ()
  (interactive)
  (modal-ins-mode 1))

(defun modal-ins-mode-enable-eol ()
  (interactive)
  (move-end-of-line nil)
  (modal-ins-mode-enable))

(defun modal-ins-mode-enable-first-char ()
  (interactive)
  (modal-move-to-first-char)
  (modal-ins-mode-enable))

(defun modal-ins-mode-enable-next-char ()
  (interactive)
  (unless (eolp) (forward-char))
  (modal-ins-mode-enable))

(defun modal-ins-mode-enable-open-down ()
  (interactive)
  ;; fixme: is the text at end-of-line read-only?
  (move-end-of-line nil)
  (open-line 1)
  (forward-line)
  ;; indentation is annoying in modes that have no special indentation
  ;; handlers.  it always indents as if for beginning a new paragraph.
  ;; we therefore have this experimental check for the value of
  ;; indent-line-function.  hopefully this works okay.
  (unless (eq indent-line-function 'indent-relative)
    (indent-for-tab-command))
  (modal-ins-mode-enable))

(defun modal-ins-mode-enable-open-up ()
  (interactive)
  ;; fixme: is the text at beginning-of-line read-only?
  (move-beginning-of-line nil)
  (open-line 1)
  ;; indentation is annoying in modes that have no special indentation
  ;; handlers.  it always indents as if for beginning a new paragraph.
  ;; we therefore have this experimental check for the value of
  ;; indent-line-function.  hopefully this works okay.
  (unless (eq indent-line-function 'indent-relative)
    (indent-for-tab-command))
  (modal-ins-mode-enable))

(define-minor-mode modal-ins-mode
  "insertion mode, i.e., normal editing. ESC enters
modal-cmd-mode."
  nil nil nil
  (when modal-ins-mode
    (modal-disable-others 'modal-ins-mode)
    (setq modal-current modal-ins-string)
    (force-mode-line-update)
    (setq cursor-type modal-ins-cursor-type)
    (run-hooks 'modal-ins-mode-hook)))

(add-to-list
 'modal-intercept-keymaps
 `(modal-ins-mode . ,modal-ins-intercept-map))

(add-hook 'modal-modes-list 'modal-ins-mode)



;;; modal-vilike-mode
;;;
;;;   A modality system that uses modal-cmd-mode and modal-ins-mode to
;;; produce vi-like modality.
;;;

(defvar modal-vilike-whitelist
  '((modal-cmd-mode .
		    (fundamental-mode)))
  "List of major modes in which to enable modal-cmd-mode.")

(defvar modal-vilike-derived-whitelist
  '((modal-cmd-mode .
		    (apropos-mode
		     compilation-mode
		     conf-mode
		     css-mode
		     dictionary-mode
		     diff-mode
		     espresso-mode
		     ess-mode
		     groovy-mode
		     haskell-mode
		     help-mode
		     inferior-lisp-mode
		     js2-mode
		     lua-mode
		     Man-mode
		     mgp-mode
		     modal-fundamental-mode
		     prog-mode
		     reb-mode
		     text-mode)))
  "Modal-cmd-mode will be enabled in any major mode matching or
derived from from a mode in this list.")

(define-minor-mode modal-vilike-mode
  "A modality system that uses modal-cmd-mode and
modal-ins-mode to produce vi-like modality."
  nil nil nil
  (cond
   (modal-vilike-mode
    (setq
     modal-local-whitelist modal-vilike-whitelist
     modal-local-derived-whitelist modal-vilike-derived-whitelist)
    (add-hook 'lui-mode-hook 'modal-cmd-mode-enable)
    (add-hook 'lui-pre-input-hook 'modal-cmd-mode-enable))
   (t
    (setq
     modal-local-whitelist nil
     modal-local-derived-whitelist nil)
    (remove-hook 'lui-mode-hook 'modal-cmd-mode-enable)
    (remove-hook 'lui-pre-input-hook 'modal-cmd-mode-enable))))

;; set modal-vilike-mode as the default modality system
(setq modal-system 'modal-vilike-mode)


;;;;
;;;; AUXILIARY MODES
;;;;

;;; modal-mode-line-background-mode
;;;
;;;   A minor mode to track changes of the modal mode with the
;;; mode-line's background color.
;;;
;;; XXX: this mode can only be globally on or off.  it can't be on only in
;;; GUI windows, and off in textual windows.
;;;

(defvar modal-mode-line-background-colors
  '((modal-ins-mode "gray75")
    (modal-cmd-mode "cornflower blue")
    (t "gray75"))
  "Associations of modal modes and the colors to be used for the
mode-line background.  This structure is really just the guts of
a `cond', so make sure the last entry is for `t'.")

(defun modal-mode-line-background-update ()
  (when (eq (current-buffer)
            (window-buffer (selected-window)))
    (set-face-background
     'mode-line
     (eval (cons 'cond modal-mode-line-background-colors))
     (selected-frame))))

(define-minor-mode modal-mode-line-background-mode
  "modal mode-line background mode sets the background color of
the mode-line according to the current modal."
  nil nil nil
  (mapc
   (lambda (h)
     (funcall
      (if modal-mode-line-background-mode
          'add-hook
	'remove-hook)
      h
      'modal-mode-line-background-update))
   '(modal-ins-mode-hook
     modal-cmd-mode-hook
     window-configuration-change-hook)))



;;; modal-fundamental-mode
;;;
;;;   This mode is a simple wrapper around fundamental-mode, which
;;; adds no features, but when set as your default-major-mode, makes
;;; it possible to automatically use modal-mode in buffers that take
;;; the default mode.
;;;

(define-derived-mode modal-fundamental-mode fundamental-mode
  "Modal-Fundamental"
  "Modal-Fundamental mode is a simple wrapper for
fundamental-mode which adds no features, except if you set it as
your `default-major-mode', modal-mode will work in it
automatically, which is not the case for fundamental-mode
itself.")

(load-file "~/.emacs.d/modal/modal-changes.el")

(provide 'modal-mode)
;;; modal-mode.el ends here
