;; this is useful for creating custum lisp filse
;; do not add "~/emacs.d" to the load path. This can apparently cause problems.
(add-to-list 'load-path "~/.emacs.d/my-custom-files")
(add-to-list 'load-path "~/.emacs.d/elpa")

(load "definitions")
(load "variables")
(load "macros")
(load "hooks")
(load "skeletons")
(load "set-global-keys")
;;(load "gnus-set-up.el")
;;(load "evil-changes")

;;make emacs shell output color
;;(ansi-color-for-comint-mode-on)

;;web mode
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))

;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
;;'(hl-line ((t (:background "dim gray"))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks")
 '(custom-enabled-themes (quote (zenburn)))
 '(custom-safe-themes
   (quote
    ("9dae95cdbed1505d45322ef8b5aa90ccb6cb59e0ff26fef0b8f411dfc416c552" "3b819bba57a676edf6e4881bd38c777f96d1aa3b3b5bc21d8266fa5b0d0f1ebf" "146d24de1bb61ddfa64062c29b5ff57065552a7c4019bee5d869e938782dfc2a" default)))
 '(electric-pair-mode t)
 '(global-hl-line-mode t)
 '(semantic-new-buffer-setup-functions
   (quote
    ((emacs-lisp-mode . semantic-default-scheme-setup)
     (c-mode . semantic-default-c-setup)
     (c++-mode . semantic-default-c-setup)
     (html-mode . semantic-default-html-setup)
     (java-mode . wisent-java-default-setup)
     (js-mode . wisent-javascript-setup-parser)
     (python-mode . wisent-python-default-setup)
     (scheme-mode . semantic-default-scheme-setup)
     (srecode-template-mode . srecode-template-setup-parser)
     (texinfo-mode . semantic-default-texi-setup)
     (makefile-automake-mode . semantic-default-make-setup)
     (makefile-gmake-mode . semantic-default-make-setup)
     (makefile-makepp-mode . semantic-default-make-setup)
     (makefile-bsdmake-mode . semantic-default-make-setup)
     (makefile-imake-mode . semantic-default-make-setup)
     (makefile-mode . semantic-default-make-setup))))
 '(uniquify-buffer-name-style (quote post-forward) nil (uniquify)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
