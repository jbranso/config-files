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
	    (byte-compile-file "/home/joshua/.emacs.d/init.el")
	    (byte-recompile-directory "/home/joshua/.emacs.d/my-custom-files")))

;; lisp mode hook
(add-hook 'lisp-mode-hook '(lambda ()
			     ;;  auto-fill-mode is great for comments in lisp
			     (auto-fill-mode)))

;; make org mode start up with auto fill mode
(add-hook 'org-mode-hook '(lambda ()
			    (auto-fill-mode)
			    (visual-line-mode)
			    ;;refill mode is pretty amazing. If you are getting tired of pressing M-q all
			    ;;the time to fill paragraphs then turn on refill-mode.
			    ;; Be warned though, auto-fill-mode, refill-mode, and probably visual line mode,
			    ;; assume that the user follows the U.S. convention of using two spaces between
			    ;; sentences. If you do not follow this convention, or you add this to your init
			    ;; file...
			    ;; (sentence-end-double-space nil)
			    ;; bad things will happen. You have been warned.
			    ;;https://www.gnu.org/software/emacs/manual/html_node/emacs/Auto-Fill.html
			    ;;https://www.gnu.org/software/emacs/manual/html_node/emacs/Sentences.html
			    (refill-mode)
			    (setq ac-sources '(ac-source-semantic
					       ac-source-yasnippet
					       ac-source-ispell
					       ac-source-ispell-fuzzy))))

;;enabling minor modes for my major modes
;;(add-hook '<major mode>-mode-hook '<minor mode name>-mode) this works.
(add-hook 'cc-mode-hook 'yas-minor-mode)
(add-hook 'c++-mode-hook 'yas-minor-mode)
(add-hook 'python-mode-hook 'yas-minor-mode)
(add-hook 'lua-mode-hook 'yas-minor-mode)

(add-hook 'web-mode-hook
	  (lambda ()
	    (flyspell-prog-mode)
	    (yas-minor-mode)
	    (emmet-mode)
	    (visual-line-mode)
	    ;;  (ac-ispell-ac-setup)
	    (setq ac-sources '(ac-source-semantic
			       ac-source-yasnippet
			       ac-source-jquery
			       ac-source-css-property
			       ac-source-ispell
			       ac-source-ispell-fuzzy))))

(add-hook 'c++-mode-hook
	  '(lambda ()
	     (flyspell-prog-mode)
	     (yas-minor-mode)
	     ))

(add-hook 'c-mode-hook '(lambda ()
			  (flyspell-prog-mode)
			  (yas-minor-mode)
			  (setq ac-sources '(ac-source-ispell
					     ac-source-ispell-fuzzy))))
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

;;auto-insert, specifes default stuff to load into the emacs file when you create a file.
;; setq buffer-save... will let you save every buffer you open without asking if you want to save it.
(add-hook 'find-file-hook (lambda ()
			    (setq buffer-save-without-query t)
			    (auto-insert)))
;; not working
(add-hook 'eshell-first-time-mode-hook 'viper-change-state-to-emacs)
(add-hook 'eshell-mode-hook 'viper-change-state-to-emacs)
(add-hook 'term-mode-hook 'viper-change-state-to-emacs)
