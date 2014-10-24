;;(cond (or (equal (current-buffer) "hooks.el")
;;	  (equal (current-buffer) "definitions.el"))
;;      (compile-file (current-buffer)))

(add-hook 'dired-load-hook
	  (lambda ()
	    (load "dired-x")
	    ;; Set dired-x global variables here.  For example:
	    ;; (setq dired-guess-shell-gnutar "gtar")
	    ;; (setq dired-x-hands-off-my-keys nil)
	    ))
(add-hook 'dired-mode-hook
	  (lambda ()
	    ;; Set dired-x buffer-local variables here.  For example:
	    ;; (dired-omit-mode 1)
	    ))


;;delete trailing whitespace
(add-hook 'before-save-hook
	  (lambda ()
	    (delete-trailing-whitespace)
	    (indent-region (point-min) (point-max))))

(add-hook 'after-save-hook
	  (lambda ()
	    (if (string= (buffer-file-name) "/home/joshua/.emacs.d/init.el")
		(byte-compile-file "/home/joshua/.emacs.d/init.el")
	      (byte-recompile-directory "/home/joshua/.emacs.d/my-custom-files"))))

;; make org mode start up with auto fill mode
(add-hook 'org-mode-hook '(lambda ()
			    (auto-fill-mode)
			    ;; this should be possible, to define certain keys for viper when
			    ;; certain files are open. That is not happening here.
			    ;; (define-key viper-vi-global-user-map (kbd "ct")  'org-todo)
			    ;; (define-key viper-vi-global-user-map (kbd "cb")  'ido-switch-buffer)
			    ;; (define-key viper-vi-global-user-map (kbd "TAB") 'viper-org-cycle)
			    ))

;;(add-hook 'web-mode-hook 'auto-fill-mode)
(global-visual-line-mode 1)

;;enabling minor modes for my major modes
;;(add-hook '<major mode>-mode-hook '<minor mode name>-mode) this works.
(add-hook 'cc-mode-hook 'auto-insert-mode)
(add-hook 'c++-mode-hook 'auto-insert-mode)
(add-hook 'python-mode-hook 'auto-insert-mode)
(add-hook 'lua-mode-hook 'auto-insert-mode)
(add-hook 'html-mode-hook 'auto-insert-mode)
(add-hook 'web-mode-hook 'auto-insert-mode)

;;(add-hook 'cc-mode-hook 'yas-minor-mode-on)
;;(add-hook 'c++-mode-hook 'yas-minor-mode)
;;(add-hook 'python-mode-hook 'yas-minor-mode-on)
;;(add-hook 'lua-mode-hook 'yas-minor-mode)
;;(add-hook 'html-mode-hook 'yas-minor-mode-on)
;;(add-hook 'web-mode-hook 'yas-minor-mode)


(add-hook 'cc-mode-hook 'abbrev-mode)
(add-hook 'c++-mode-hook 'abbrev-mode)
(add-hook 'python-mode-hook 'abbrev-mode)
(add-hook 'lua-mode-hook 'abbrev-mode)
(add-hook 'html-mode-hook 'abbrev-mode)
(add-hook 'web-mode-hook 'abbrev-mode)

(dolist (hook '(text-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))

(add-hook 'c++-mode-hook
          (lambda ()
            (flyspell-prog-mode)
	    ))

(add-hook 'c-mode-hook 'flyspell-prog-mode)

(add-hook 'lua-mode-hook
          (lambda ()
            (flyspell-prog-mode)
	    ))

(add-hook 'python-mode-hook
          (lambda ()
            (flyspell-prog-mode)
	    ))

(add-hook 'bash-mode-hook
          (lambda ()
            (flyspell-prog-mode)
	    ))

;; add a ton of minor modes to text mode this is causing problems when editing HTML mode
(add-hook 'text-mode-hook 'flyspell-mode)

;;auto-insert, specifes default stuff to load into the emacs file when you create a file.
;; setq buffer-save... will let you save every buffer you open without asking if you want to save it.
(add-hook 'find-file-hook (lambda ()
			    (setq buffer-save-without-query t)
			    (auto-insert)))

;; not working
(add-hook 'eshell-first-time-mode-hook 'viper-change-state-to-emacs)
(add-hook 'eshell-mode-hook 'viper-change-state-to-emacs)
(add-hook 'term-mode-hook 'viper-change-state-to-emacs)
