;;(keyboard-translate ?\C-x ?\M-x) ;;make C-x mean M-x
;;(keyboard-translate ?\C-t ?\C-x) ;;make C-t mean C-x
;; this sets up the packages I have installed.
(package-initialize)
(tool-bar-mode -1)
(menu-bar-mode -1)

;; put numbers on the side of the editor
(global-linum-mode 1)
;; this is an alternative to skeletons
;;(yas-global-mode 1)
;;change yes or no to y or n
(fset 'yes-or-no-p 'y-or-n-p)

;; set the font size... This species a font size of 14 pt
(set-face-attribute 'default nil :height 140)

;; this is useful for creating custum lisp filse
;; do not add "~/emacs.d" to the load path. This can apparently cause problems.
(add-to-list 'load-path "~/.emacs.d/my-custom-files")

(load "setq")
(load "macros")
(load "definitions")
(load "hooks")
(load "skeletons")
(load "set-global-keys")
;;(load "evil-changes")

;;make emacs shell output color
(ansi-color-for-comint-mode-on)

;;web mode
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[gj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

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
 '(ansi-color-names-vector ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(custom-enabled-themes (quote (zenburn)))
 '(custom-safe-themes (quote ("146d24de1bb61ddfa64062c29b5ff57065552a7c4019bee5d869e938782dfc2a" default)))
 '(electric-pair-mode t)
 '(global-hl-line-mode t)
 ;; '(ido-auto-merge-delay-time 1.0)
 ;; '(ido-cannot-complete-command (quote ido-next-match))
 ;; '(ido-enable-regexp t)
 ;; '(ido-enable-tramp-completion t)
 ;; '(ido-ignore-buffers (quote ("\*scratch\*" "\*Messages\*" "\*Compile-Log\*" "\*help\*" "*.vr" "*.tp" "*.toc" "*.pg" "*.log" "*.ky" "*.fn" "*.cp" "*.aux" "\\` ")))
 ;; '(ido-ignore-files (quote ("*.vr" "*.toc" "*.tp" "*.pg" "*.log" "*.ky" "*.fn" "*.cp" "*.aux" "\\`CVS/" "\\`#" "\\`.#" "\\`\\.\\./" "\\`\\./")))
 ;; '(ido-max-dir-file-cache 200)
 ;; '(ido-max-work-directory-list 100)
 ;; '(ido-max-work-file-list 20)
 '(uniquify-buffer-name-style (quote post-forward) nil (uniquify)))
