;; this is useful for creating custum lisp filse
;; do not add "~/emacs.d" to the load path. This can apparently cause problems.
(add-to-list 'load-path "~/.emacs.d/my-custom-files")
(add-to-list 'load-path "~/.emacs.d/modal")

(load "variables")
(load "macros")
(load "definitions")
(load "hooks")
(load "skeletons")
(load "set-global-keys")
;;(load "evil-changes")

;;make emacs shell output color
(ansi-color-for-comint-mode-on)

;;web mode
(add-to-list 'auto-mode-alist '("\\.php?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css?\\'" . web-mode))

;; the default file emacs opens.
;;(find-file "/home/joshua/documents/things_to_do.org")

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
    ("3b819bba57a676edf6e4881bd38c777f96d1aa3b3b5bc21d8266fa5b0d0f1ebf" "146d24de1bb61ddfa64062c29b5ff57065552a7c4019bee5d869e938782dfc2a" default)))
 '(electric-pair-mode t)
 '(global-hl-line-mode t)
 '(uniquify-buffer-name-style (quote post-forward) nil (uniquify)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
