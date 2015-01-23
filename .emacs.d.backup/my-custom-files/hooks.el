;; (or (equal (current-buffer) "hooks.gl")
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
	  '(lambda ()
	     (delete-trailing-whitespace)
	     (indent-region (point-min) (point-max))))
;; if the current buffer that is being saved is an .el file, then eval it, and byte recomplile all my start
;; up emacs files
;; This next line should not be needed since, I've downloaded autocompile.
;;(add-hook 'after-save-hook 'byte-recompile-emacs-config-files)

;; lisp mode hook
(add-hook 'lisp-mode-hook '(lambda ()
			     ;;  auto-fill-mode is great for comments in lisp
			     (git-gutter-mode)
			     (auto-fill-mode)))

;; A classic example would be lambda from various Lisp dialects that many people prefer to replace with the greek letter λ (small lambda). prettify-symbols-mode allows you to achieve this by relying on a simple mapping expressed in the form of an alist that each major mode must initialize (prettify-symbols-alist). Simply put - major modes have to provide the configuration for prettify-symbols-mode.

;; Lisp modes do this via lisp--prettify-symbols-alist:
;; (defconst lisp--prettify-symbols-alist
;;   '(("lambda"  . ?λ)))

;; This means that out of the box only lambda will get replaced. You can, of course, add more mappings for different major modes:

;; (add-hook 'emacs-lisp-mode-hook
;;             (lambda ()
;;               (push '(">=" . ?≥) prettify-symbols-alist)))

;; emacs-lisp mode hook
(add-hook 'emacs-lisp-mode-hook '(lambda ()
				   ;;  auto-fill-mode is great for comments in lisp
				   (git-gutter-mode)
				   (auto-fill-mode)
				   (push '(">=" . ?≥) prettify-symbols-alist)))


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
			    (push '(">=" . ?≥) prettify-symbols-alist)
			    (push '("<=" . ?≤) prettify-symbols-alist)
			    (push '("\\geq" . ?≥) prettify-symbols-alist)
			    (push '("\\leq" . ?≤) prettify-symbols-alist)
			    (push '("\\neg" . ?¬) prettify-symbols-alist)
			    (push '("\\rightarrow" . ?→) prettify-symbols-alist)
			    (push '("\\leftarrow" . ?←) prettify-symbols-alist)
			    (push '("\\infty" . ?∞) prettify-symbols-alist)
			    (push '("-->" . ?→) prettify-symbols-alist)
			    (push '("<--" . ?←) prettify-symbols-alist)
			    (push '("\\exists" . ?∃) prettify-symbols-alist)
			    (push '("\\nexists" . ?∄) prettify-symbols-alist)
			    (push '("\\forall" . ?∀) prettify-symbols-alist)
			    (push '("\\or" . ?∨) prettify-symbols-alist)
			    (push '("\\and" . ?∧) prettify-symbols-alist)
			    (push '(":)" . ?☺) prettify-symbols-alist)
			    (push '("):" . ?☹) prettify-symbols-alist)
			    (push '(":D" . ?☺) prettify-symbols-alist)
			    (push '("^_^" . ?☻) prettify-symbols-alist)

			    (let ((original-command (lookup-key org-mode-map [tab])))
			      `(lambda ()
				 (setq yas-fallback-behavior
				       '(apply ,original-command))
				 (local-set-key [tab] 'yas-expand)))))

;;enabling minor modes for my major modes
;;(add-hook '<major mode>-mode-hook '<minor mode name>-mode) this works.
(add-hook 'cc-mode-hook '(lambda () (interactive)
			   (push '("function" . ?𝆑) prettify-symbols-alist)
			   (push '(">=" . ?≥) prettify-symbols-alist)
			   (push '("<=" . ?≤) prettify-symbols-alist)
			   yas-minor-mode))

(add-hook 'js-mode-hook '(lambda () (interactive)
			   (push '("function" . ?𝆑) prettify-symbols-alist)
			   (push '(">=" . ?≥) prettify-symbols-alist)
			   (push '("<=" . ?≤) prettify-symbols-alist)
			   yas-minor-mode))

(add-hook 'web-mode-hook
	  (lambda ()
	    (flyspell-prog-mode)
	    (yas-minor-mode)
	    (push '("function" . ?𝆑) prettify-symbols-alist)
	    (push '(">=" . ?≥) prettify-symbols-alist)
	    (push '("<=" . ?≤) prettify-symbols-alist)
	    (visual-line-mode)

	    (auto-fill-mode)
	    ;;  (ac-ispell-ac-setup)
	    (add-to-list 'ac-sources 'ac-source-jquery)
	    ;; This is being really annoying
	    ;; (add-to-list 'ac-sources 'ac-source-css-property)
	    ))

(add-hook 'c++-mode-hook
	  '(lambda ()
	     (flyspell-prog-mode)
	     (yas-minor-mode)
	     ))

(add-hook 'c-mode-hook '(lambda ()
			  (flyspell-prog-mode)
			  (yas-minor-mode)
			  (push '("function" . ?𝆑) prettify-symbols-alist)
			  (push '(">=" . ?≥) prettify-symbols-alist)
			  (push '("<=" . ?≤) prettify-symbols-alist)
			  ;;(add-to-list 'ac-sources 'ac-source-c-headers)
			  ))
(add-hook 'lua-mode-hook
	  '(lambda ()
	     (flyspell-prog-mode)
	     (yas-minor-mode)
	     (push '("function" . ?𝆑) prettify-symbols-alist)
	     (push '(">=" . ?≥) prettify-symbols-alist)
	     (push '("<=" . ?≤) prettify-symbols-alist)
	     ))

(add-hook 'python-mode-hook
	  '(lambda ()
	     (flyspell-prog-mode)
	     (yas-minor-mode)
	     (push '("function" . ?𝆑) prettify-symbols-alist)
	     (push '(">=" . ?≥) prettify-symbols-alist)
	     (push '("<=" . ?≤) prettify-symbols-alist)
	     ))

(add-hook 'bash-mode-hook
	  '(lambda ()
	     (flyspell-prog-mode)
	     (push '("function" . ?𝆑) prettify-symbols-alist)
	     (push '(">=" . ?≥) prettify-symbols-alist)
	     (push '("<=" . ?≤) prettify-symbols-alist)
	     ))

(add-hook 'text-mode-hook
	  '(lambda ()
	     (refill-mode)
	     (flyspell-mode)
	     (set-fill-column 108)
	     (push '(":)" . ?☺) prettify-symbols-alist)
	     (push '("):" . ?☹) prettify-symbols-alist)
	     (push '(":D" . ?☺) prettify-symbols-alist)
	     (push '("^_^" . ?☻) prettify-symbols-alist)
	     (push '(">=" . ?≥) prettify-symbols-alist)
	     (push '("<=" . ?≤) prettify-symbols-alist)
	     (ruler-mode)))

;;auto-insert, specifes default stuff to load into the emacs file when you create a file.
;; setq buffer-save... will let you save every buffer you open without asking if you want to save it.
(add-hook 'find-file-hook '(lambda ()
			     (setq buffer-save-without-query t)
			     (auto-insert)))

;; this is in the right direction, but I the evil-normal-state-exit hook is not working to make m go back to
;;being the regular key it is supposed to be.
;;(add-hook 'evil-normal-state-entry-hook '(lambda ()
;;					  (define-key key-translation-map "M" (kbd "ESC"))))

;;(add-hook 'evil-normal-state-exit-hook '(lambda ()
;;					  (define-key key-translation-map "M" "M")))
