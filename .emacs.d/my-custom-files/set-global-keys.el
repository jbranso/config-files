(autoload 'dired-jump "dired-x"
  "Jump to Dired buffer corresponding to current buffer." t)
(define-key global-map "\C-x\C-j" 'dired-jump)
