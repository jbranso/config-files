;;; evil-changes.el --- My custom evil stuff         -*- lexical-binding: t; -*-

;; Copyright (C) 2014

;; Author:  <joshua@arch>
;; Keywords: wp

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; wooo hooo

;;; Code:

;; Make evil-insert-mode allow emacs keybindings
(setcdr evil-insert-state-map nil)
(define-key evil-insert-state-map
  (kbd "ESC") 'evil-normal-state)

(define-key evil-normal-state-map "s" 'evil-forward-char)
(define-key evil-normal-state-map "n" 'evil-backward-char)
(define-key evil-normal-state-map "t" 'evil-previous-line)
(define-key evil-normal-state-map "h" 'evil-next-line)
(define-key evil-normal-state-map (kbd "C-l") 'recenter-top-bottom)
(define-key evil-normal-state-map "l" 'recenter-top-bottom)
(define-key evil-normal-state-map "o" 'recenter-top-bottom)
(define-key evil-normal-state-map "e" 'recenter-top-bottom)
(define-key evil-normal-state-map (kbd "'l") 'execute-extented-command)
(define-key evil-normal-state-map
  (kbd "v") 'viper-scroll-up)
(define-key evil-normal-state-map
  (kbd "V") 'viper-scroll-down)
(define-key evil-normal-state-map
  (kbd "<backspace>") 'delete-backward-char)
(define-key evil-normal-state-map
  (kbd "l") 'recenter-top-bottom)
;;there is no need to set return to newline-and-indent, because electric-indent-mode is now on by default.
(define-key evil-normal-state-map
  (kbd "<return>") 'newline)
(define-key evil-normal-state-map
  (kbd "SPC") 'viper-space)
(define-key evil-normal-state-map
  (kbd "C-f") 'forward-char)
(define-key evil-normal-state-map
  (kbd "C-a") 'mark-whole-buffer)


(define-key evil-normal-state-map
  (kbd "a") '(lambda ()
	       (interactive)
	       (beginning-of-line)
	       (indent-for-tab-command)))
(define-key evil-normal-state-map
  (kbd "M-a") 'backward-paragraph)
(define-key evil-normal-state-map
  (kbd "A") 'backward-paragraph)
(define-key evil-normal-state-map
  (kbd "u") 'end-of-line)
(define-key evil-normal-state-map
  (kbd "M-u") 'forward-paragraph)
(define-key evil-normal-state-map
  (kbd "U") 'forward-paragraph)
(define-key evil-normal-state-map
  (kbd "e")'forward-word)
(define-key evil-normal-state-map
  (kbd "E") 'forward-sentence)
(define-key evil-normal-state-map
  (kbd "M-e")'forward-sentence)
(define-key evil-normal-state-map
  (kbd "o")'backward-word)
(define-key evil-normal-state-map
  (kbd "O") 'backward-sentence)
(define-key evil-normal-state-map
  (kbd "M-o")' 'backword-sentence)
(define-key evil-normal-state-map
  (kbd ".") 'viper-undo)
(define-key evil-normal-state-map
  (kbd ",") 'viper-repeat)

(define-key evil-normal-state-map
  (kbd "C-h") 'help)
(define-key evil-normal-state-map
  (kbd "C-d") 'delete-char)

;; the c commands
;;(define-key evil-normal-state-map
;;  (kbd "c SPC") 'ace-jump-char-mode)
;; This will let you browse through all the stuff you've killed.
;; this conflicts with ph
;;(define-key evil-normal-state-map
;;  (kbd "phk") 'browse-kill-ring)

;;(define-key evil-normal-state-map
;;  (kbd "de") 'kill-word)
;;(define-key evil-normal-state-map
;;  (kbd "do") 'backward-kill-word)
;;cut from point to the end of the line
;;(define-key evil-normal-state-map
;;  (kbd "du") '(lambda ()
;;		(interactive)
;;		(kill-visual-line nil)))
;;cut/kill from point to the beginning of the line
;;(define-key evil-normal-state-map
;;  (kbd "da") '(lambda ()
;;		(interactive)
;;		(kill-visual-line 0)))

;;(define-key evil-normal-state-map
;;   (kbd "ck") 'kill-region)

;;This is an awesome idea for a command, but I'm not sure how to do it.
;;I could do the same thing with c SPC.
;;(define-key evil-normal-state-map
;;  (kbd "d SPC") '(lambda ()
;;		   (interactive)
;;		   (let (beg end)
;;		     (setq beg (point))
;;		     (ace-jump-char-mode (read-char "Query Char:"))
;;		     (setq end (point))
;;		     (kill-region beg end))))
;;(define-key evil-normal-state-map
;; (kbd "cbk") 'web-mode-block-kill)
;;(define-key evil-normal-state-map
;;  (kbd "cP") 'viper-put-back)
;;(define-key evil-normal-state-map
;;  (kbd "cp") 'viper-Put-back)
;;(define-key evil-normal-state-map
;;  (kbd "cr") 'repeat)
;;(define-key evil-normal-state-map
;;  (kbd "cxc") 'save-buffers-kill-terminal)
;;(define-key evil-normal-state-map
					;  (kbd "c'") 'helm-M-x)
(define-key evil-normal-state-map
  (kbd "<") 'beginning-of-buffer)
(define-key evil-normal-state-map
  (kbd ">") 'end-of-buffer)
(define-key evil-normal-state-map
  (kbd "c3") 'split-window-right)
(define-key evil-normal-state-map
  (kbd "c2") 'split-window-below)
(define-key evil-normal-state-map
  (kbd "c1") 'delete-other-windows)
(define-key evil-normal-state-map
  (kbd "c0") '(lambda ()
		(interactive)
		(other-window 1)
		(delete-other-windows)))
(define-key evil-normal-state-map
  (kbd "cj") 'join-bottom-line)
(define-key evil-normal-state-map
  (kbd "cq") 'delete-window)

;;the m commands
(define-key evil-normal-state-map
  (kbd "mlu") 'move-line-up)
(define-key evil-normal-state-map
  (kbd "mld") 'move-line-down)
(define-key evil-normal-state-map
  (kbd "mm") 'viper-register-macro)
(define-key evil-normal-state-map
  (kbd "m.") 'set-mark-command)
(define-key evil-normal-state-map
  (kbd "M") 'viper-alternate-Meta-key)
(define-key evil-normal-state-map
  (kbd "ESC $") 'helm-flyspell-correct)
(define-key evil-normal-state-map
  (kbd "mh") 'web-mode-mark-and-expand)
(define-key evil-normal-state-map
  (kbd "mnt") 'mc/mark-next-like-this)


;;p commands
(define-key evil-normal-state-map
  (kbd "p SPC") 'ace-jump-char-mode)
(define-key evil-normal-state-map
  (kbd "'s") '(lambda ()
		(interactive)
		(save-some-buffers t)))
(define-key evil-normal-state-map
  (kbd "ps") 'helm-swoop)
(define-key evil-normal-state-map
  (kbd "pd") 'dired-jump)
(define-key evil-normal-state-map
  (kbd "p<") 'shrink-window-horizontally)
(define-key evil-normal-state-map
  (kbd "p>") 'enlarge-window-horizontally)
(define-key evil-normal-state-map
  (kbd "p^") 'enlarge-window) ;;make the inverse of this
(define-key evil-normal-state-map
  (kbd "pv") 'scroll-other-window)
(define-key evil-normal-state-map
  (kbd "pel") 'eval-last-sexp)
(define-key evil-normal-state-map
  (kbd "'n") 'web-mode-navigate)

(define-key evil-normal-state-map
  (kbd "feb") 'web-mode-element-beginning)
(define-key evil-normal-state-map
  (kbd "fee") 'web-mode-element-end)

(define-key evil-normal-state-map
  (kbd "gg") 'goto-line)
(define-key evil-normal-state-map
  (kbd "gn") 'web-mode-navigate)
;;copy words and lines get this working
(define-key evil-normal-state-map
  (kbd "ca") '(lambda ()
		(interactive)
		(kill-visual-line 0)
		(undo)))
(define-key evil-normal-state-map
  (kbd "cu") '(lambda ()
		(interactive)
		(kill-visual-line nil)
		(yank)
		(beginning-of-line)))

(define-key evil-normal-state-map
  (kbd "co") '(lambda ()
		(interactive)
		(let (firstLetter lastLetter)
		  (backward-word)
		  (setq firstLetter (point))
		  (forward-word)
		  (setq lastLetter (point))
		  (kill-ring-save firstLetter lastLetter))))

(define-key evil-normal-state-map
  (kbd "ce") '(lambda ()
		(interactive)
		(let (firstLetter lastLetter)
		  (forward-word)
		  (backward-word)
		  (setq firstLetter (point))
		  (forward-word)
		  (setq lastLetter (point))
		  (kill-ring-save firstLetter lastLetter))))

;; the p commands
(define-key evil-normal-state-map
  (kbd "pN") 'viper-newline)
(define-key evil-normal-state-map
  (kbd "pn") 'viper-Newline)
(define-key evil-normal-state-map
  (kbd "p;") 'er/mark-comment)
(define-key evil-normal-state-map
  (kbd "p.") 'er/expand-region)
(define-key evil-normal-state-map
  (kbd "p,") 'er/contract-region)
(define-key evil-normal-state-map
  (kbd "prp") 'insert-register)
(define-key evil-normal-state-map
  (kbd "pr+") 'increment-register)
(define-key evil-normal-state-map
  (kbd "prc") 'copy-to-register)
(define-key evil-normal-state-map
  (kbd "prn") 'number-to-register)
(define-key evil-normal-state-map
  (kbd "prn") 'number-to-register)
;; this will prompt you for a register name. It will store the current buffer position in a register
(define-key evil-normal-state-map
  (kbd "pr.") 'point-to-register)
;;This will prompt you for a register name. It will move point to that register's value.
(define-key evil-normal-state-map
  (kbd "prj") 'jump-to-register)

;;org/agenda commands
(define-key evil-normal-state-map (kbd "ct")  'org-todo)
(define-key evil-normal-state-map (kbd "cis")  'org-schedule)
(define-key evil-normal-state-map (kbd "cid")  'org-deadline)


(define-key evil-normal-state-map
  (kbd "w;") 'web-mode-comment-or-uncomment)
(define-key evil-normal-state-map
  (kbd "wf") 'web-mode-fold-or-unfold)
(define-key evil-normal-state-map
  (kbd "pf") 'web-mode-fold-or-unfold)
(define-key evil-normal-state-map
  (kbd "pb") 'helm-mini)
;;copy marked region
(define-key evil-normal-state-map
  (kbd "pc") 'kill-ring-save)
(define-key evil-normal-state-map
  (kbd "pre") 'web-mode-element-rename)
(define-key evil-normal-state-map
  (kbd "pt") 'web-mode-element-parent)
(define-key evil-normal-state-map
  (kbd "ph") 'web-mode-element-child)
;; pa copies from point to beginning of line
;; pu copies from point to the beginning of the line



(define-key evil-normal-state-map
  (kbd "kb") 'ido-kill-buffer)
(define-key evil-normal-state-map
  (kbd "kw") '(lambda ()
		(interactive)
		(backward-word nil)
		(kill-word nil)))
(define-key evil-normal-state-map
  (kbd "kl") 'kill-line)
(define-key evil-normal-state-map
  (kbd "ke") 'web-mode-element-vanish)

(define-key evil-normal-state-map
  (kbd "q") '(lambda ()
	       (interactive)
	       (let (kill-buffer-query-functions) (kill-buffer))))

(define-key evil-normal-state-map
  (kbd "yn") 'windmove-left)
(define-key evil-normal-state-map
  (kbd "ys") 'windmove-right)
(define-key evil-normal-state-map
  (kbd "yt") 'windmove-up)
(define-key evil-normal-state-map
  (kbd "yh") 'windmove-down)
(define-key evil-normal-state-map
  (kbd "yf") 'helm-for-files)

;; this should prevent making the escape key moving the cursor backwards but...
;; (define-key viper-insert-global-user-map
;;   (kbd "ESC") '(lambda()
;; 		 (viper-intercept-ESC-key)
;; 		 (forward-char)))
(define-key viper-insert-global-user-map
  (kbd "C-d") 'delete-char)
(define-key viper-insert-global-user-map
  (kbd "<backspace>") 'delete-backward-char)

(define-key viper-insert-global-user-map
  (kbd "<return>") 'newline-and-indent)

;; dired
(define-key viper-dired-modifier-map "h" 'dired-next-line)
(define-key viper-dired-modifier-map "t" 'dired-previous-line)
(define-key viper-dired-modifier-map "c'" 'helm-M-x)
(define-key viper-dired-modifier-map "cb" 'ido-switch-buffer)
(define-key viper-dired-modifier-map ".." 'dired-up-directory)
(define-key viper-dired-modifier-map ".," 'dired-undo)
(define-key viper-dired-modifier-map "cr" 'repeat)

(define-key evil-normal-state-map
  (kbd "v") 'viper-scroll-up)
(define-key evil-normal-state-map
  (kbd "V") 'viper-scroll-down)
(define-key evil-normal-state-map
  (kbd "<backspace>") 'delete-backward-char)
(define-key evil-normal-state-map
  (kbd "l") 'recenter-top-bottom)
;;there is no need to set return to newline-and-indent, because electric-indent-mode is now on by default.
(define-key evil-normal-state-map
  (kbd "<return>") 'newline)
(define-key evil-normal-state-map
  (kbd "SPC") 'viper-space)
(define-key evil-normal-state-map
  (kbd "C-f") 'forward-char)
(define-key evil-normal-state-map
  (kbd "C-a") 'mark-whole-buffer)


(define-key evil-normal-state-map
  (kbd "a") '(lambda ()
	       (interactive)
	       (beginning-of-line)
	       (indent-for-tab-command)))
(define-key evil-normal-state-map
  (kbd "M-a") 'backward-paragraph)
(define-key evil-normal-state-map
  (kbd "A") 'backward-paragraph)
(define-key evil-normal-state-map
  (kbd "u") 'end-of-line)
(define-key evil-normal-state-map
  (kbd "M-u") 'forward-paragraph)
(define-key evil-normal-state-map
  (kbd "U") 'forward-paragraph)
(define-key evil-normal-state-map
  (kbd "e")'forward-word)
(define-key evil-normal-state-map
  (kbd "E") 'forward-sentence)
(define-key evil-normal-state-map
  (kbd "M-e")'forward-sentence)
(define-key evil-normal-state-map
  (kbd "o")'backward-word)
(define-key evil-normal-state-map
  (kbd "O") 'backward-sentence)
(define-key evil-normal-state-map
  (kbd "M-o")' 'backword-sentence)
(define-key evil-normal-state-map
  (kbd ".") 'viper-undo)
(define-key evil-normal-state-map
  (kbd ",") 'viper-repeat)

(define-key evil-normal-state-map
  (kbd "C-h") 'help)
(define-key evil-normal-state-map
  (kbd "C-d") 'delete-char)

;; the c commands
(define-key evil-normal-state-map
  (kbd "c SPC") 'ace-jump-char-mode)
;; This will let you browse through all the stuff you've killed.
;; this conflicts with ph
;;(define-key evil-normal-state-map
;;  (kbd "phk") 'browse-kill-ring)

(define-key evil-normal-state-map
  (kbd "de") 'kill-word)
(define-key evil-normal-state-map
  (kbd "do") 'backward-kill-word)
;;cut from point to the end of the line
(define-key evil-normal-state-map
  (kbd "du") '(lambda ()
		(interactive)
		(kill-visual-line nil)))
;;cut/kill from point to the beginning of the line
(define-key evil-normal-state-map
  (kbd "da") '(lambda ()
		(interactive)
		(kill-visual-line 0)))
(define-key evil-normal-state-map
  (kbd "dd") '(lambda ()
		(interactive)
		(beginning-of-line)
		(kill-line)
		(delete-backward-char 1)
		(next-line)))
(define-key evil-normal-state-map
  (kbd "ck") 'kill-region)

;;This is an awesome idea for a command, but I'm not sure how to do it.
;;I could do the same thing with c SPC.
(define-key evil-normal-state-map
  (kbd "d SPC") '(lambda ()
		   (interactive)
		   (let (beg end)
		     (setq beg (point))
		     (ace-jump-char-mode (read-char "Query Char:"))
		     (setq end (point))
		     (kill-region beg end))))
(define-key evil-normal-state-map
  (kbd "cbk") 'web-mode-block-kill)
(define-key evil-normal-state-map
  (kbd "cP") 'viper-put-back)
(define-key evil-normal-state-map
  (kbd "cp") 'viper-Put-back)
(define-key evil-normal-state-map
  (kbd "cr") 'repeat)
(define-key evil-normal-state-map
  (kbd "cxc") 'save-buffers-kill-terminal)
(define-key evil-normal-state-map
  (kbd "c'") 'helm-M-x)
(define-key evil-normal-state-map
  (kbd "<") 'beginning-of-buffer)
(define-key evil-normal-state-map
  (kbd ">") 'end-of-buffer)
(define-key evil-normal-state-map
  (kbd "c3") 'split-window-right)
(define-key evil-normal-state-map
  (kbd "c2") 'split-window-below)
(define-key evil-normal-state-map
  (kbd "c1") 'delete-other-windows)
(define-key evil-normal-state-map
  (kbd "c0") '(lambda ()
		(interactive)
		(other-window 1)
		(delete-other-windows)))
(define-key evil-normal-state-map
  (kbd "cle") 'copy-last-html-element)
(define-key evil-normal-state-map
  (kbd "cne") 'copy-next-html-element)
(define-key evil-normal-state-map
  (kbd "cj") 'join-bottom-line)
(define-key evil-normal-state-map
  (kbd "cq") 'delete-window)


;;the m commands
(define-key evil-normal-state-map
  (kbd "mlu") 'move-line-up)
(define-key evil-normal-state-map
  (kbd "mld") 'move-line-down)
(define-key evil-normal-state-map
  (kbd "mm") 'viper-register-macro)
(define-key evil-normal-state-map
  (kbd "m.") 'set-mark-command)
(define-key evil-normal-state-map
  (kbd "M") 'viper-alternate-Meta-key)
(define-key evil-normal-state-map
  (kbd "ESC $") 'helm-flyspell-correct)
(define-key evil-normal-state-map
  (kbd "mh") 'web-mode-mark-and-expand)
(define-key evil-normal-state-map
  (kbd "mnt") 'mc/mark-next-like-this)


;;p commands
(define-key evil-normal-state-map
  (kbd "p SPC") 'ace-jump-char-mode)
(define-key evil-normal-state-map
  (kbd "'s") '(lambda ()
		(interactive)
		(save-some-buffers t)))
(define-key evil-normal-state-map
  (kbd "ps") 'helm-swoop)
(define-key evil-normal-state-map
  (kbd "pd") 'dired-jump)
(define-key evil-normal-state-map
  (kbd "p<") 'shrink-window-horizontally)
(define-key evil-normal-state-map
  (kbd "p>") 'enlarge-window-horizontally)
(define-key evil-normal-state-map
  (kbd "p^") 'enlarge-window) ;;make the inverse of this
(define-key evil-normal-state-map
  (kbd "pv") 'scroll-other-window)
(define-key evil-normal-state-map
  (kbd "pel") 'eval-last-sexp)
(define-key evil-normal-state-map
  (kbd "'n") 'web-mode-navigate)

(define-key evil-normal-state-map
  (kbd "feb") 'web-mode-element-beginning)
(define-key evil-normal-state-map
  (kbd "fee") 'web-mode-element-end)

(define-key evil-normal-state-map
  (kbd "gg") 'goto-line)
(define-key evil-normal-state-map
  (kbd "gn") 'web-mode-navigate)
;;copy words and lines get this working
(define-key evil-normal-state-map
  (kbd "ca") '(lambda ()
		(interactive)
		(kill-visual-line 0)
		(undo)))
(define-key evil-normal-state-map
  (kbd "cu") '(lambda ()
		(interactive)
		(kill-visual-line nil)
		(yank)
		(beginning-of-line)))

(define-key evil-normal-state-map
  (kbd "co") '(lambda ()
		(interactive)
		(let (firstLetter lastLetter)
		  (backward-word)
		  (setq firstLetter (point))
		  (forward-word)
		  (setq lastLetter (point))
		  (kill-ring-save firstLetter lastLetter))))

(define-key evil-normal-state-map
  (kbd "ce") '(lambda ()
		(interactive)
		(let (firstLetter lastLetter)
		  (forward-word)
		  (backward-word)
		  (setq firstLetter (point))
		  (forward-word)
		  (setq lastLetter (point))
		  (kill-ring-save firstLetter lastLetter))))

;; the p commands
(define-key evil-normal-state-map
  (kbd "pN") 'viper-newline)
(define-key evil-normal-state-map
  (kbd "pn") 'viper-Newline)
(define-key evil-normal-state-map
  (kbd "p;") 'er/mark-comment)
(define-key evil-normal-state-map
  (kbd "p.") 'er/expand-region)
(define-key evil-normal-state-map
  (kbd "p,") 'er/contract-region)
(define-key evil-normal-state-map
  (kbd "prp") 'insert-register)
(define-key evil-normal-state-map
  (kbd "pr+") 'increment-register)
(define-key evil-normal-state-map
  (kbd "prc") 'copy-to-register)
(define-key evil-normal-state-map
  (kbd "prn") 'number-to-register)
(define-key evil-normal-state-map
  (kbd "prn") 'number-to-register)
;; this will prompt you for a register name. It will store the current buffer position in a register
(define-key evil-normal-state-map
  (kbd "pr.") 'point-to-register)
;;This will prompt you for a register name. It will move point to that register's value.
(define-key evil-normal-state-map
  (kbd "prj") 'jump-to-register)

;;org/agenda commands
(define-key evil-normal-state-map (kbd "ct")  'org-todo)
(define-key evil-normal-state-map (kbd "cis")  'org-schedule)
(define-key evil-normal-state-map (kbd "cid")  'org-deadline)


(define-key evil-normal-state-map
  (kbd "w;") 'web-mode-comment-or-uncomment)
(define-key evil-normal-state-map
  (kbd "wf") 'web-mode-fold-or-unfold)
(define-key evil-normal-state-map
  (kbd "pf") 'web-mode-fold-or-unfold)
(define-key evil-normal-state-map
  (kbd "pb") 'helm-mini)
;;copy marked region
(define-key evil-normal-state-map
  (kbd "pc") 'kill-ring-save)
(define-key evil-normal-state-map
  (kbd "pre") 'web-mode-element-rename)
(define-key evil-normal-state-map
  (kbd "pt") 'web-mode-element-parent)
(define-key evil-normal-state-map
  (kbd "ph") 'web-mode-element-child)
;; pa copies from point to beginning of line
;; pu copies from point to the beginning of the line



(define-key evil-normal-state-map
  (kbd "kb") 'ido-kill-buffer)
(define-key evil-normal-state-map
  (kbd "kw") '(lambda ()
		(interactive)
		(backward-word nil)
		(kill-word nil)))
(define-key evil-normal-state-map
  (kbd "kl") 'kill-line)
(define-key evil-normal-state-map
  (kbd "ke") 'web-mode-element-vanish)

(define-key evil-normal-state-map
  (kbd "q") '(lambda ()
	       (interactive)
	       (let (kill-buffer-query-functions) (kill-buffer))))

(define-key evil-normal-state-map
  (kbd "yn") 'windmove-left)
(define-key evil-normal-state-map
  (kbd "ys") 'windmove-right)
(define-key evil-normal-state-map
  (kbd "yt") 'windmove-up)
(define-key evil-normal-state-map
  (kbd "yh") 'windmove-down)
(define-key evil-normal-state-map
  (kbd "yf") 'helm-for-files)

;; this should prevent making the escape key moving the cursor backwards but...
;; (define-key viper-insert-global-user-map
;;   (kbd "ESC") '(lambda()
;; 		 (viper-intercept-ESC-key)
;; 		 (forward-char)))
(define-key viper-insert-global-user-map
  (kbd "C-d") 'delete-char)
(define-key viper-insert-global-user-map
  (kbd "<backspace>") 'delete-backward-char)

(define-key viper-insert-global-user-map
  (kbd "<return>") 'newline-and-indent)

;; dired
;;(define-key viper-dired-modifier-map "h" 'dired-next-line)
;;(define-key viper-dired-modifier-map "t" 'dired-previous-line)
;;(define-key viper-dired-modifier-map "c'" 'helm-M-x)
;;(define-key viper-dired-modifier-map "cb" 'ido-switch-buffer)
;;(define-key viper-dired-modifier-map ".." 'dired-up-directory)
;;(define-key viper-dired-modifier-map ".," 'dired-undo)
;;(define-key viper-dired-modifier-map "cr" 'repeat)

(provide 'evil-changes)
;;; evil-changes.el ends here
