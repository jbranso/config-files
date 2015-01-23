(autoload 'dired-jump "dired-x"
  "Jump to Dired buffer corresponding to current buffer." t)

(define-key global-map "\C-x\C-j" 'dired-jump)
(define-key global-map (kbd "C-c C-x r") 'refill-mode)
;; comment any highlighted region or uncomment it.
(define-key global-map (kbd "C-c ;") 'comment-dwim)
(define-key global-map (kbd "C-c t") 'transpose-chars)

;; This is not needed since dired buffers will now use emacs state.
;;(define-key dired-mode-map (kbd "h") 'dired-next-line)
;;(define-key dired-mode-map (kbd "t") 'dired-previous-line)
