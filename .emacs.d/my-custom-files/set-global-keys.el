(autoload 'dired-jump "dired-x"
  "Jump to Dired buffer corresponding to current buffer." t)
(define-key global-map "\C-x\C-j" 'dired-jump)

(define-key dired-mode-map
  (kbd "h") 'dired-next-line)

(define-key dired-mode-map
  (kbd "t") 'dired-previous-line)

;;these commands are not working.
;; (define-key 'org-agenda-mode-map
;;   (kbd "h") 'org-agenda-next-line)

;; (define-key 'org-agenda-mode-map
;;   (kbd "t") 'org-agenda-previous-line)


(define-key dired-mode-map
  (kbd "n") 'dired-next-line)


(define-key dired-mode-map
  (kbd "n") 'dired-next-line)


(define-key dired-mode-map
  (kbd "n") 'dired-next-line)
