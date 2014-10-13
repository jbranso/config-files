(keyboard-translate ?\C-x ?\M-x) ;;make C-x mean M-x
(keyboard-translate ?\C-t ?\C-x) ;;make C-t mean C-x
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; this sets up the packages I have installed.
(package-initialize)
(blink-cursor-mode nil)

;; put numbers on the side of the editor
(global-linum-mode 1)
;; this is an alternative to skeletons
;;(yas-global-mode 1)
;;change yes or no to y or n
(fset 'yes-or-no-p 'y-or-n-p)
(setq-default fill-column 108)

;;yes I do want to kill this shell, even though it has a process attached to it.
(setq kill-buffer-query-functions
      (remq 'process-kill-buffer-query-function
	    kill-buffer-query-functions))

;; set the font size... This species a font size of 14 pt
(set-face-attribute 'default nil :height 140)

;;setq variables
;; these are some basic emacs configurations that I like
;; don't show the startup screen
(setq inhibit-startup-message t)
;; "C-h d transient" will give you more information
(setq transient-mark-mode t)
;;stop making backup files
(setq make-backup-files nil)
;; show matching parenthesis
(show-paren-mode t)

;;(ido-mode t)
(setq ido-enable-flex-matching t)
(setq ido-create-new-buffer 'always)
(setq ido-use-filename-at-point 'guess)
(setq ido-ignore-buffers (quote ("*.vr" "*.tp" "*.toc" "*.pg" "*.log" "*.ky" "*.fn" "*.cp" "*.aux" "\\` ")))
(ido-mode 1)

;; the following lines must be before init loads my hooks, because my hooks
;; change some viper commands based upon what file is loaded.
;; For example, my org-mode-hook binds "ct" to (org-todo).
(setq viper-mode t)
(require 'viper)
;;(require 'evil)
;;(evil-mode 1)


;; this is useful for creating custum lisp filse
(add-to-list 'load-path "~/.emacs.d/my-custom-files")
(add-to-list 'load-path "~/.emacs.d/org-mode/lisp")
(add-to-list 'load-path "~/.emacs.d/org-mode/contrib/lisp" t)
(load "~/.emacs.d/org-mode/lisp/org.el")

(load "macros")
(load "definitions")
(load "hooks")
(load "skeletons")
;;(load "evil-changes")

;; this makes C-n add a new line if point is at the end of the buffer. that you you don't
;; have to use return if you don't want to.
(setq next-line-add-newlines t)

;; this lets emacs package system download the latest and greatest org and org-contrib packages
;; this version of emacs does not have a package manager
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

;;default keybindings for org-mode. I added these myself. They make any file that ends in .org, be opened in org mode.
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; tell emacs where my agenda file is
(setq org-agenda-files (quote ("~/documents/things_to_do.org")))

;;this will record what time TODO items were finished and the line containing 'note will make org prompt you for a note when you finish
;; a task
(setq org-log-done 'time)

;;speed up flyspell
(setq flyspell-issue-message-flag nil)
;; make flyspell use aspell
(setq ispell-list-command "--list")

;; toggle follow mode in emacs agenda mode
(setq org-agenda-start-with-follow-mode t)

;; scroll one line at a time (less "jumpy" than defaults)

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time

(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling

(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

(setq scroll-step 1) ;; keyboard scroll one line at a time

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

(find-file "/home/joshua/documents/things_to_do.org")

 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hl-line ((t (:background "dim gray"))))
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
 '(ido-auto-merge-delay-time 1.0)
 '(ido-cannot-complete-command (quote ido-next-match))
 '(ido-enable-regexp t)
 '(ido-enable-tramp-completion t)
 '(ido-ignore-buffers (quote ("*" "*.vr" "*.tp" "*.toc" "*.pg" "*.log" "*.ky" "*.fn" "*.cp" "*.aux" "\\` ")))
 '(ido-ignore-files (quote ("*.vr" "*.toc" "*.tp" "*.pg" "*.log" "*.ky" "*.fn" "*.cp" "*.aux" "\\`CVS/" "\\`#" "\\`.#" "\\`\\.\\./" "\\`\\./")))
 '(ido-max-dir-file-cache 200)
 '(ido-max-work-directory-list 100)
 '(ido-max-work-file-list 20)
 '(menu-bar-mode nil)
 '(org-agenda-files nil)
 '(tool-bar-mode nil)
 '(uniquify-buffer-name-style (quote post-forward) nil (uniquify)))
