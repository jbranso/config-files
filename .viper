(setq viper-expert-level '4)
(setq viper-vi-style-in-minibuffer nil) ;;this make vi insert state be emacs state

;;vi state modifications
(define-key viper-vi-global-user-map
  (kbd "n") 'backward-char)
(define-key viper-vi-global-user-map
  (kbd "h") 'next-line)
(define-key viper-vi-global-user-map
  (kbd "t") 'previous-line)
(define-key viper-vi-global-user-map
  (kbd "s") 'forward-char)
(define-key viper-vi-global-user-map
  (kbd "v") 'viper-scroll-up)
(define-key viper-vi-global-user-map
  (kbd "V") 'viper-scroll-down)
(define-key viper-vi-global-user-map
  (kbd "a")'viper-beginning-of-line)
(define-key viper-vi-global-user-map
  (kbd "u") 'move-end-of-line)
(define-key viper-vi-global-user-map
  (kbd "e")'forward-word)
(define-key viper-vi-global-user-map
  (kbd "o")'backward-word)
(define-key viper-vi-global-user-map
  (kbd "ce") 'kill-word)
(define-key viper-vi-global-user-map
  (kbd "co")'backward-kill-word)
(define-key viper-vi-global-user-map
  (kbd "C-a") 'viper-delete-backward-word)
(define-key viper-vi-global-user-map
  (kbd "C-o") 'kill-word)
(define-key viper-vi-global-user-map
  (kbd ".") 'viper-undo)
(define-key viper-vi-global-user-map
  (kbd ",") 'viper-repeat)
(define-key viper-vi-global-user-map
  (kbd "C-h") 'help)
(define-key viper-vi-global-user-map
  (kbd "C-d") 'delete-char)
(define-key viper-vi-global-user-map
  (kbd "C-u") 'universal-argument)

;; the c commands
(define-key viper-vi-global-user-map
  (kbd "cc") 'kill-ring-save)
(define-key viper-vi-global-user-map
  (kbd "cu") 'kill-region)
(define-key viper-vi-global-user-map
  (kbd "cp") 'viper-put-back)
(define-key viper-vi-global-user-map
  (kbd "cP") 'viper-Put-back)
(define-key viper-vi-global-user-map
  (kbd "cy") 'yank)
(define-key viper-vi-global-user-map
  (kbd "cs") 'save-buffer)
(define-key viper-vi-global-user-map
  (kbd "cxc") 'save-buffers-kill-terminal)
(define-key viper-vi-global-user-map
  (kbd "cf") 'ido-find-file)
(define-key viper-vi-global-user-map
  (kbd "cb") 'ido-switch-buffer)
(define-key viper-vi-global-user-map
  (kbd "ca") 'execute-extended-command)
(define-key viper-vi-global-user-map
  (kbd "c<") 'beginning-of-buffer)
(define-key viper-vi-global-user-map
  (kbd "c>") 'end-of-buffer)
(define-key viper-vi-global-user-map
  (kbd "c3") 'split-window-right)
(define-key viper-vi-global-user-map
  (kbd "c2") 'split-window-below)
(define-key viper-vi-global-user-map
  (kbd "c1") 'delete-other-windows)
(define-key viper-vi-global-user-map
  (kbd "ck") 'ido-kill-buffer)
(define-key viper-vi-global-user-map
  (kbd "ck") 'ido-kill-buffer)
(define-key viper-vi-global-user-map
  (kbd "crp") 'insert-register)
(define-key viper-vi-global-user-map
  (kbd "cr+") 'increment-register)
(define-key viper-vi-global-user-map
  (kbd "crc") 'copy-to-register)
(define-key viper-vi-global-user-map
  (kbd "crn") 'number-to-register)
(define-key viper-vi-global-user-map
  (kbd "crn") 'number-to-register)
(define-key viper-vi-global-user-map
  (kbd "cle") 'copy-last-html-element)
(define-key viper-vi-global-user-map
  (kbd "cne") 'copy-next-html-element)
(define-key viper-vi-global-user-map
  (kbd "cj") 'join-bottom-line)
(define-key viper-vi-global-user-map
  (kbd "c.") 'set-mark-command)

(define-key viper-vi-global-user-map
  (kbd "C-d") 'delete-char)
(define-key viper-vi-global-user-map
  (kbd "Oo") 'viper-open-line)
(define-key viper-vi-global-user-map
  (kbd "OO") 'viper-Open-line)
(define-key viper-vi-global-user-map
  (kbd "<backspace>") 'delete-backward-char)
(define-key viper-vi-global-user-map
  (kbd "l") 'recenter-top-bottom)
(define-key viper-vi-global-user-map
  (kbd "<return>") 'newline-and-indent)
(define-key viper-vi-global-user-map
  (kbd "SPC") 'viper-space)

(define-key viper-vi-global-user-map
  (kbd "mlu") 'move-line-up)
(define-key viper-vi-global-user-map
  (kbd "mld") 'move-line-down)
(define-key viper-vi-global-user-map
  (kbd "mm") 'viper-register-macro)
(define-key viper-vi-global-user-map
  (kbd "mh") 'set-mark-command)
(define-key viper-vi-global-user-map
  (kbd "M") 'viper-alternate-Meta-key)
(define-key viper-vi-global-user-map
  (kbd "'") 'viper-alternate-Meta-key)
(define-key viper-vi-global-user-map
  (kbd "m;") 'er/mark-comment)
(define-key viper-vi-global-user-map
  (kbd "mnt") 'mc/mark-next-like-this)
(define-key viper-vi-global-user-map
  (kbd "mpt") 'er/mark-previous-like-this)
(define-key viper-vi-global-user-map
  (kbd "mu") 'er/mark-url)
(define-key viper-vi-global-user-map
  (kbd "mw") 'er/mark-word)


;; p Commands
(define-key viper-vi-global-user-map
  (kbd "ps") 'isearch-forward-regexp)
(define-key viper-vi-global-user-map
  (kbd "pb") 'isearch-backward-regexp)
(define-key viper-vi-global-user-map
  (kbd "pr") 'recentf-open-files)
(define-key viper-vi-global-user-map
  (kbd "ph") 'help)
(define-key viper-vi-global-user-map
  (kbd "p<") 'shrink-window-horizontally)
(define-key viper-vi-global-user-map
  (kbd "p>") 'enlarge-window-horizontally)
(define-key viper-vi-global-user-map
  (kbd "p^") 'enlarge-window) ;;make the inverse of this
(define-key viper-vi-global-user-map
  (kbd "pv") 'scroll-other-window)
(define-key viper-vi-global-user-map
  (kbd "pel") 'eval-last-sexp)

(define-key viper-vi-global-user-map
  (kbd "gg") 'goto-line)
(define-key viper-vi-global-user-map
  (kbd "gc") 'ace-jump-char-mode)
(define-key viper-vi-global-user-map
  (kbd "gs") 'ace-jump-mode)
(define-key viper-vi-global-user-map
  (kbd "gn") 'web-mode-navigate)


(define-key viper-vi-global-user-map
  (kbd "po") 'other-window)
;; the y commands
(define-key viper-vi-global-user-map
  (kbd "pn") 'viper-newline)
(define-key viper-vi-global-user-map
  (kbd "pN") 'viper-Newline)
(define-key viper-vi-global-user-map
  (kbd "p;") 'er/mark-comment)
(define-key viper-vi-global-user-map
  (kbd "p.") 'er/expand-region)
(define-key viper-vi-global-user-map
  (kbd "p,") 'er/contract-region)
;;org/agenda commands

(define-key viper-vi-global-user-map (kbd "ct")  'org-todo)
(define-key viper-vi-global-user-map (kbd "c.")  'org-time-stamp)
;;(define-key viper-vi-global-user-map
;;  (kbd "dl") 'kill-line)

(define-key viper-vi-global-user-map
  (kbd "w;") 'web-mode-comment-or-uncomment)
(define-key viper-vi-global-user-map
  (kbd "wf") 'web-mode-fold-or-unfold)
(define-key viper-vi-global-user-map
  (kbd "pf") 'web-mode-fold-or-unfold)


(define-key viper-vi-global-user-map
  (kbd "<return>") 'newline-and-indent)
(define-key viper-insert-global-user-map
  (kbd "C-d") 'delete-char)
(define-key viper-insert-global-user-map
  (kbd "C-h") 'help)

;; this should prevent making the escape key moving the cursor backwards but...
;; (define-key viper-insert-global-user-map
;;   (kbd "ESC") '(lambda()
;; 		 (viper-intercept-ESC-key)
;; 		 (forward-char)))

;; dired
(define-key viper-dired-modifier-map "h" 'dired-next-line)
(define-key viper-dired-modifier-map "t" 'dired-previous-line)
(define-key viper-dired-modifier-map "j"
  '(lambda () (interactive) (dired-next-line 10)))
(define-key viper-dired-modifier-map "k"
  '(lambda () (interactive) (dired-previous-line 10)))
(setq viper-inhibit-startup-message 't)
