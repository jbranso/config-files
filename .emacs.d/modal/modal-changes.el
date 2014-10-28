;;modal-mode modifications
(define-key modal-cmd-intercept-map
  (kbd "n") 'backward-char)
(define-key modal-cmd-intercept-map
  (kbd "h") 'next-line)
(define-key modal-cmd-intercept-map
  (kbd "t") 'previous-line)
(define-key modal-cmd-intercept-map
  (kbd "s") 'forward-char)
(define-key modal-cmd-intercept-map
  (kbd "v") 'scroll-up)
(define-key modal-cmd-intercept-map
  (kbd "V") 'scroll-down)
(define-key modal-cmd-intercept-map
  (kbd "<backspace>") 'delete-backward-char)
(define-key modal-cmd-intercept-map
  (kbd "l") 'recenter-top-bottom)
(define-key modal-cmd-intercept-map
  (kbd "<return>") 'newline-and-indent)
(define-key modal-cmd-intercept-map
  (kbd "SPC") 'viper-space)

(define-key modal-cmd-intercept-map
  (kbd "a")'beginning-of-line)
(define-key modal-cmd-intercept-map
  (kbd "u") 'move-end-of-line)
(define-key modal-cmd-intercept-map
  (kbd "e")'forward-word)
(define-key modal-cmd-intercept-map
  (kbd "o")'backward-word)
(define-key modal-cmd-intercept-map
  (kbd ".") 'undo)
(define-key modal-cmd-intercept-map
  (kbd ",") 'repeat)

(define-key modal-cmd-intercept-map
  (kbd "C-h") 'help)
(define-key modal-cmd-intercept-map
  (kbd "C-d") 'delete-char)

;; the c commands
(define-key modal-cmd-intercept-map
  (kbd "c SPC") 'ace-jump-char-mode)
;; This will let you browse through all the stuff you've killed.
(define-key modal-cmd-intercept-map
  (kbd "cb") 'browse-kill-ring)
(define-key modal-cmd-intercept-map
  (kbd "ce") 'kill-word)
(define-key modal-cmd-intercept-map
  (kbd "co")'backward-kill-word)
;;cut from point to the end of the line
(define-key modal-cmd-intercept-map
  (kbd "cu") '(lambda ()
		(interactive)
		(kill-visual-line nil)))
;;cut/kill from point to the beginning of the line
(define-key modal-cmd-intercept-map
  (kbd "ca") '(lambda ()
		(interactive)
		(kill-visual-line 0)))
(define-key modal-cmd-intercept-map
  (kbd "ck") 'kill-region)
;;(define-key modal-cmd-intercept-map
;;  (kbd "cP") 'viper-put-back)
(define-key modal-cmd-intercept-map
  (kbd "cp") 'yank)
(define-key modal-cmd-intercept-map
  (kbd "cr") 'repeat)
(define-key modal-cmd-intercept-map
  (kbd "cxc") 'save-buffers-kill-terminal)
(define-key modal-cmd-intercept-map
  (kbd "c'") 'helm-M-x)
(define-key modal-cmd-intercept-map
  (kbd "<") 'beginning-of-buffer)
(define-key modal-cmd-intercept-map
  (kbd ">") 'end-of-buffer)
(define-key modal-cmd-intercept-map
  (kbd "c3") 'split-window-right)
(define-key modal-cmd-intercept-map
  (kbd "c2") 'split-window-below)
(define-key modal-cmd-intercept-map
  (kbd "c1") 'delete-other-windows)
(define-key modal-cmd-intercept-map
  (kbd "cle") 'copy-last-html-element)
(define-key modal-cmd-intercept-map
  (kbd "cne") 'copy-next-html-element)
(define-key modal-cmd-intercept-map
  (kbd "cj") 'join-bottom-line)
(define-key modal-cmd-intercept-map
  (kbd "cq") 'delete-window)


;;the m commands
(define-key modal-cmd-intercept-map
  (kbd "mlu") 'move-line-up)
(define-key modal-cmd-intercept-map
  (kbd "mld") 'move-line-down)
(define-key modal-cmd-intercept-map
  (kbd "m.") 'set-mark-command)
;;(define-key modal-cmd-intercept-map
;;  (kbd "M") 'viper-alternate-Meta-key)
(define-key modal-cmd-intercept-map
  (kbd "m;") 'er/mark-comment)
(define-key modal-cmd-intercept-map
  (kbd "mnt") 'mc/mark-next-like-this)


;;p commands
(define-key modal-cmd-intercept-map
  (kbd "p SPC") 'ace-jump-char-mode)
(define-key modal-cmd-intercept-map
  (kbd "'s") '(lambda ()
		(interactive)
		(save-some-buffers t)))
(define-key modal-cmd-intercept-map
  (kbd "ps") 'helm-swoop)
(define-key modal-cmd-intercept-map
  (kbd "pd") 'dired-jump)
(define-key modal-cmd-intercept-map
  (kbd "p<") 'shrink-window-horizontally)
(define-key modal-cmd-intercept-map
  (kbd "p>") 'enlarge-window-horizontally)
(define-key modal-cmd-intercept-map
  (kbd "p^") 'enlarge-window) ;;make the inverse of this
(define-key modal-cmd-intercept-map
  (kbd "pv") 'scroll-other-window)
(define-key modal-cmd-intercept-map
  (kbd "pel") 'eval-last-sexp)

(define-key modal-cmd-intercept-map
  (kbd "gg") 'goto-line)
;;copy words and lines get this working
(define-key modal-cmd-intercept-map
  (kbd "ga") '(lambda ()
		(interactive)
		(kill-visual-line 0)
		(undo)))
(define-key modal-cmd-intercept-map
  (kbd "gu") '(lambda ()
		(interactive)
		(kill-visual-line nil)
		(yank)
		(beginning-of-line)))

(define-key modal-cmd-intercept-map
  (kbd "go") '(lambda ()
		(interactive)
		(let (firstLetter lastLetter)
		  (backward-word)
		  (setq firstLetter (point))
		  (forward-word)
		  (setq lastLetter (point))
		  (kill-ring-save firstLetter lastLetter))))

(define-key modal-cmd-intercept-map
  (kbd "ge") '(lambda ()
		(interactive)
		(let (firstLetter lastLetter)
		  (forward-word)
		  (backward-word)
		  (setq firstLetter (point))
		  (forward-word)
		  (setq lastLetter (point))
		  (kill-ring-save firstLetter lastLetter))))

;; the p commands
(define-key modal-cmd-intercept-map
  (kbd "pn") '(lambda ()
		(interactive)
		(end-of-line)
		(newline-and-indent)))
(define-key modal-cmd-intercept-map
  (kbd "pN") '(lambda ()
		(interactive)
		(beginning-of-line)
		(newline-and-indent)
		(previous-line)))
(define-key modal-cmd-intercept-map
  (kbd "p;") 'er/mark-comment)
(define-key modal-cmd-intercept-map
  (kbd "p.") 'er/expand-region)
(define-key modal-cmd-intercept-map
  (kbd "p,") 'er/contract-region)
(define-key modal-cmd-intercept-map
  (kbd "ph") 'help)
(define-key modal-cmd-intercept-map
  (kbd "prp") 'insert-register)
(define-key modal-cmd-intercept-map
  (kbd "pr+") 'increment-register)
(define-key modal-cmd-intercept-map
  (kbd "prc") 'copy-to-register)
(define-key modal-cmd-intercept-map
  (kbd "prn") 'number-to-register)
(define-key modal-cmd-intercept-map
  (kbd "prn") 'number-to-register)
;; this will prompt you for a register name. It will store the current buffer position in a register
(define-key modal-cmd-intercept-map
  (kbd "pr.") 'point-to-register)
;;This will prompt you for a register name. It will move point to that register's value.
(define-key modal-cmd-intercept-map
  (kbd "prj") 'jump-to-register)


;;org/agenda commands
(define-key modal-cmd-intercept-map (kbd "ct")  'org-todo)
(define-key modal-cmd-intercept-map (kbd "cis")  'org-schedule)
(define-key modal-cmd-intercept-map (kbd "cid")  'org-deadline)


(define-key modal-cmd-intercept-map
  (kbd "w;") 'web-mode-comment-or-uncomment)
(define-key modal-cmd-intercept-map
  (kbd "wf") 'web-mode-fold-or-unfold)
(define-key modal-cmd-intercept-map
  (kbd "pf") 'web-mode-fold-or-unfold)
(define-key modal-cmd-intercept-map
  (kbd "pb") 'ido-switch-buffer)
;;copy marked region
(define-key modal-cmd-intercept-map
  (kbd "pc") 'kill-ring-save)
;; pa copies from point to beginning of line
;; pu copies from point to the beginning of the line



(define-key modal-cmd-intercept-map
  (kbd "kb") 'ido-kill-buffer)
(define-key modal-cmd-intercept-map
  (kbd "kl") 'kill-line)

(define-key modal-cmd-intercept-map
  (kbd "<return>") 'newline-and-indent)

(define-key modal-cmd-intercept-map
  (kbd "q") 'ido-kill-buffer)

(define-key modal-cmd-intercept-map
  (kbd "yn") 'windmove-left)
(define-key modal-cmd-intercept-map
  (kbd "ys") 'windmove-right)
(define-key modal-cmd-intercept-map
  (kbd "yt") 'windmove-up)
(define-key modal-cmd-intercept-map
  (kbd "yh") 'windmove-down)
(define-key modal-cmd-intercept-map
  (kbd "yf") 'helm-find-file)
