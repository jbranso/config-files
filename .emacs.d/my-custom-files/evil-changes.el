;; evil-changes.el --- My custom evil stuff         -*- lexical-binding: t; -*-

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

(define-key evil-normal-state-map (kbd "C-s") 'evil-substitute)
(define-key evil-normal-state-map "s" 'evil-forward-char)
(define-key evil-normal-state-map "n" 'evil-backward-char)
(define-key evil-normal-state-map "t" 'evil-previous-line)
(define-key evil-normal-state-map "h" 'evil-next-line)
(define-key evil-visual-state-map "s" 'evil-forward-char)
(define-key evil-visual-state-map "n" 'evil-backward-char)
(define-key evil-visual-state-map "t" 'evil-previous-line)
(define-key evil-visual-state-map "h" 'evil-next-line)

(define-key evil-normal-state-map (kbd "C-l") 'recenter-top-bottom)
(define-key evil-normal-state-map "l" 'recenter-top-bottom)
(define-key evil-normal-state-map "o" 'evil-backward-word-end)
(define-key evil-normal-state-map "e" 'evil-forward-word-end)
(define-key evil-normal-state-map "O" 'evil-backward-WORD-end)
(define-key evil-normal-state-map "E" 'evil-forward-WORD-end)
(define-key evil-normal-state-map (kbd "C-h") 'evil-open-below)
(define-key evil-normal-state-map (kbd "C-t") 'evil-open-above)
(define-key evil-normal-state-map (kbd "C-c h") 'help)
(define-key evil-normal-state-map "," 'undo-tree-undo)
(define-key evil-normal-state-map "/" 'helm-swoop)
(define-key evil-normal-state-map "'" 'evil-goto-mark)
(define-key evil-normal-state-map (kbd "C-c m") 'evil-record-macro)
(define-key evil-normal-state-map (kbd "C-c b") 'eval-buffer)
(define-key evil-normal-state-map "Q" 'query-replace)


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
  (kbd "C-a") 'mark-whole-buffer)


(define-key evil-normal-state-map
  (kbd "a") 'evil-first-non-blank)
(define-key evil-normal-state-map
  (kbd "A") 'evil-insert-line)
(define-key evil-normal-state-map (kbd "u") 'evil-end-of-line)
(define-key evil-normal-state-map (kbd "U") 'evil-append-line)

(define-key evil-normal-state-map (kbd "C-c m") 'helm-mini)
(define-key evil-normal-state-map
  (kbd "C-d") 'delete-char)

(define-key evil-normal-state-map
  (kbd "<") 'beginning-of-buffer)
(define-key evil-normal-state-map
  (kbd ">") 'end-of-buffer)

(define-key evil-normal-state-map
  (kbd "q") '(lambda ()
	       (interactive)
	       (let (kill-buffer-query-functions) (kill-buffer))))

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
  (kbd "C-a") 'mark-whole-buffer)
(define-key evil-insert-state-map (kbd "C-i") 'info-display-manual)
(define-key evil-normal-state-map
  (kbd "C-d") 'delete-char)
(define-key evil-normal-state-map
  (kbd "C-c e") 'helm-M-x)



;;This is an awesome idea for a command, but I'm not sure how to do it.

;; pa copies from point to beginning of line
;; pu copies from point to the beginning of the line

(define-key evil-normal-state-map
  (kbd "q") '(lambda ()
	       (interactive)
	       (let (kill-buffer-query-functions) (kill-buffer))))


;; this should prevent making the escape key moving the cursor backwards but...
;; (define-key viper-insert-global-user-map
;;   (kbd "ESC") '(lambda()
;; 		 (viper-intercept-ESC-key)
;; 		 (forward-char)))
(define-key evil-insert-state-map (kbd "C-d") 'delete-char)
(define-key evil-insert-state-map (kbd "<backspace>") 'delete-backward-char)
(define-key evil-insert-state-map (kbd "<return>") 'newline-and-indent)
(define-key evil-insert-state-map (kbd "C-n") 'backward-char)
(define-key evil-insert-state-map (kbd "C-h") 'next-line)
(define-key evil-insert-state-map (kbd "C-t") 'previous-line)
(define-key evil-insert-state-map (kbd "C-s") 'forward-char)
(define-key evil-insert-state-map (kbd "C-c h") 'help)
(define-key evil-insert-state-map (kbd "C-i") 'info-display-manual)

(provide 'evil-changes)
;;; evil-changes.el ends here
