;;rs of the GNU General Public License as published by
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

;; the complete list of evil states:
;; <N> normal state
;; <I> insert state
;; <V> visual state
;; <R> replace state
;; <O> operator pending state
;; <M> motion state
;; <E> emacs state

;; Make evil-insert-mode allow emacs keybindings
(setcdr evil-insert-state-map nil)
(define-key evil-insert-state-map
  (kbd "ESC") 'evil-normal-state)

(define-key evil-motion-state-map "s" 'evil-forward-char)
(define-key evil-motion-state-map "n" 'evil-backward-char)
(define-key evil-motion-state-map "t" 'evil-previous-line)
(define-key evil-motion-state-map "h" 'evil-next-line)
(define-key evil-motion-state-map "u" 'evil-end-of-line)
(define-key evil-motion-state-map "a" 'evil-first-non-blank)
(define-key evil-motion-state-map "o" 'evil-backward-word-begin)
(define-key evil-motion-state-map "e" 'evil-forward-word-begin)
;; I would like to use these, but they do not work well with golden-ratio-mode
;;(define-key evil-motion-state-map (kbd "C-w h") 'evil-window-down)
;;(define-key evil-motion-state-map (kbd "C-w t") 'evil-window-up)
;;(define-key evil-motion-state-map (kbd "C-w n") 'evil-window-left)
;;(define-key evil-motion-state-map (kbd "C-w s") 'evil-window-right)
(define-key evil-motion-state-map (kbd "C-w h") 'windmove-down)
(define-key evil-motion-state-map (kbd "C-w t") 'windmove-up)
(define-key evil-motion-state-map (kbd "C-w n") 'windmove-left)
(define-key evil-motion-state-map (kbd "C-w s") 'windmove-right)

(define-key evil-operator-state-map "s" 'evil-forward-char)
(define-key evil-operator-state-map "n" 'evil-backward-char)
(define-key evil-operator-state-map "t" 'evil-previous-line)
(define-key evil-operator-state-map "h" 'evil-next-line)
;;(define-key evil-operator-state-map "u" 'evil-end-of-line)
;;(define-key evil-operator-state-map "a" 'evil-first-non-blank)
(define-key evil-operator-state-map "o" 'evil-backward-word-begin)
(define-key evil-operator-state-map "e" 'evil-forward-word-begin)
(define-key evil-operator-state-map "O" 'evil-backward-WORD-end)
(define-key evil-operator-state-map "E" 'evil-forward-WORD-end)
(define-key evil-operator-state-map (kbd "<backspace>") 'ace-jump-char-mode)

(define-key evil-visual-state-map "s" 'evil-forward-char)
(define-key evil-visual-state-map "n" 'evil-backward-char)
(define-key evil-visual-state-map "t" 'evil-previous-line)
(define-key evil-visual-state-map "h" 'evil-next-line)
;;I what to be able to use vaw (visual around word)
;;(define-key evil-visual-state-map "u" 'evil-end-of-line)
;;(define-key evil-visual-state-map "a" 'evil-first-non-blank)
(define-key evil-visual-state-map "o" 'evil-backward-word-begin)
(define-key evil-visual-state-map "e" 'evil-forward-word-begin)
(define-key evil-visual-state-map "O" 'evil-backward-WORD-end)
(define-key evil-visual-state-map "E" 'evil-forward-WORD-end)
(define-key evil-visual-state-map (kbd "<backspace>") 'ace-jump-char-mode)

(define-key evil-replace-state-map (kbd "C-s") 'evil-substitute)
(define-key evil-replace-state-map "s" 'evil-forward-char)
(define-key evil-replace-state-map "n" 'evil-backward-char)
(define-key evil-replace-state-map "t" 'evil-previous-line)
(define-key evil-replace-state-map "h" 'evil-next-line)
;; if a === 'evil-first-non-blank, then caw (change around word), won't work.
;;(define-key evil-replace-state-map "u" 'evil-end-of-line)
;;(define-key evil-replace-state-map "a" 'evil-first-non-blank)
(define-key evil-replace-state-map "o" 'evil-backward-word-begin)
(define-key evil-replace-state-map "e" 'evil-forward-word-begin)
(define-key evil-replace-state-map "O" 'evil-backward-WORD-end)
(define-key evil-replace-state-map "E" 'evil-forward-WORD-end)
;; this is sooo cool!!!!
(define-key evil-replace-state-map (kbd "<backspace>") 'ace-jump-char-mode)

(define-key evil-normal-state-map (kbd "C-s") 'evil-substitute)
(define-key evil-normal-state-map "$" 'ispell-word)
(define-key evil-normal-state-map "s" 'evil-forward-char)
(define-key evil-normal-state-map "n" 'evil-backward-char)
(define-key evil-normal-state-map "t" 'evil-previous-line)
(define-key evil-normal-state-map "h" 'evil-next-line)
(define-key evil-normal-state-map (kbd "C-l") 'recenter-top-bottom)
(define-key evil-normal-state-map "l" 'recenter-top-bottom)
(define-key evil-normal-state-map "o" 'evil-backward-word-begin)
(define-key evil-normal-state-map "e" 'evil-forward-word-begin)
(define-key evil-normal-state-map "O" 'evil-backward-WORD-end)
(define-key evil-normal-state-map "E" 'evil-forward-WORD-end)
(define-key evil-normal-state-map "j" 'evil-join)
(define-key evil-normal-state-map (kbd "C-h") 'evil-open-below)
(define-key evil-normal-state-map (kbd "C-t") 'evil-open-above)
(define-key evil-normal-state-map (kbd "C-c h") 'help)
(define-key evil-normal-state-map (kbd "C-c d") 'dired-jump)
(define-key evil-normal-state-map (kbd "C-c g") 'magit-status)
(define-key evil-normal-state-map (kbd "C-c b") 'eval-buffer)
(define-key evil-normal-state-map (kbd "C-c l") 'eval-last-sexp)
(define-key evil-normal-state-map (kbd "C-c r") 'evil-record-macro)
(define-key evil-normal-state-map (kbd "C-c b") 'eval-buffer)
(define-key evil-normal-state-map (kbd "C-c t") '(lambda ()
						   (interactive)
						   (eval-buffer nil)
						   (learn-evil)))
(define-key evil-normal-state-map (kbd "M") (kbd "ESC"))
;; I would like to use these, but they do not work well with golden-ratio-mode
;;(define-key evil-normal-state-map (kbd "C-w h") 'evil-window-down)
;;(define-key evil-normal-state-map (kbd "C-w t") 'evil-window-up)
;;(define-key evil-normal-state-map (kbd "C-w n") 'evil-window-left)
;;(define-key evil-normal-state-map (kbd "C-w s") 'evil-window-right)
(define-key evil-normal-state-map (kbd "C-w h") 'windmove-down)
(define-key evil-normal-state-map (kbd "C-w t") 'windmove-up)
(define-key evil-normal-state-map (kbd "C-w n") 'windmove-left)
(define-key evil-normal-state-map (kbd "C-w s") 'windmove-right)
(define-key evil-normal-state-map "," 'undo-tree-undo)
(define-key evil-normal-state-map "/" 'helm-swoop)
(define-key evil-normal-state-map "'" 'evil-goto-mark)
(define-key evil-normal-state-map "Q" 'query-replace)
(define-key evil-normal-state-map (kbd "<backspace>") 'ace-jump-char-mode)
(define-key evil-normal-state-map (kbd "l") 'recenter-top-bottom)
;;there is no need to set return to newline-and-indent, because electric-indent-mode is now on by default.
(define-key evil-normal-state-map (kbd "<return>") 'newline)
(define-key evil-normal-state-map (kbd "SPC") 'viper-space)
(define-key evil-normal-state-map (kbd "C-a") 'mark-whole-buffer)
(define-key evil-normal-state-map (kbd "a") 'evil-first-non-blank)
(define-key evil-normal-state-map (kbd "A") 'evil-insert-line)
(define-key evil-normal-state-map (kbd "u") 'evil-end-of-line)
(define-key evil-normal-state-map (kbd "U") 'evil-append-line)
(define-key evil-normal-state-map (kbd "C-c m") 'helm-mini)
(define-key evil-normal-state-map (kbd "C-d") 'delete-char)
(define-key evil-normal-state-map (kbd "<") 'beginning-of-buffer)
(define-key evil-normal-state-map (kbd ">") 'end-of-buffer)
(define-key evil-normal-state-map
  (kbd "q") '(lambda ()
	       (interactive)
	       (let (kill-buffer-query-functions) (kill-buffer))))
(define-key evil-normal-state-map (kbd "l") 'recenter-top-bottom)
;;there is no need to set return to newline-and-indent, because electric-indent-mode is now on by default.
(define-key evil-normal-state-map (kbd "<return>") 'newline)
(define-key evil-normal-state-map (kbd "SPC") 'viper-space)
(define-key evil-normal-state-map (kbd "C-a") 'mark-whole-buffer)
(define-key evil-insert-state-map (kbd "C-i") 'info-display-manual)
(define-key evil-normal-state-map (kbd "C-d") 'delete-char)
(define-key evil-normal-state-map (kbd "C-c e") 'helm-M-x)
(define-key evil-normal-state-map (kbd "q") '(lambda ()
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

(define-key evil-emacs-state-map (kbd "C-c h") 'help)
(define-key evil-emacs-state-map (kbd "C-c d") 'dired-jump)
(define-key evil-emacs-state-map (kbd "C-c g") 'magit-status)
(define-key evil-emacs-state-map (kbd "C-c b") 'eval-buffer)
(define-key evil-emacs-state-map (kbd "C-c l") 'eval-last-sexp)
(define-key evil-emacs-state-map (kbd "C-c r") 'evil-record-macro)
(define-key evil-emacs-state-map (kbd "C-c b") 'eval-buffer)
(define-key evil-emacs-state-map (kbd "C-c t") '(lambda ()
						  (interactive)
						  (eval-buffer nil)
						  (learn-evil)))
(define-key evil-emacs-state-map (kbd "M") (kbd "ESC"))
;; I would like to use these, but they do not work well with golden-ratio-mode
;;(define-key evil-emacs-state-map (kbd "C-w h") 'evil-window-down)
;;(define-key evil-emacs-state-map (kbd "C-w t") 'evil-window-up)
;;(define-key evil-emacs-state-map (kbd "C-w n") 'evil-window-left)
;;(define-key evil-emacs-state-map (kbd "C-w s") 'evil-window-right)
(define-key evil-emacs-state-map (kbd "C-w h") 'windmove-down)
(define-key evil-emacs-state-map (kbd "C-w t") 'windmove-up)
(define-key evil-emacs-state-map (kbd "C-w n") 'windmove-left)
(define-key evil-emacs-state-map (kbd "C-w s") 'windmove-right)


(provide 'evil-changes)
;;; evil-changes.el ends here
