
;; variables.el --- Setting variables                    -*- lexical-binding: t; -*-

;; Copyright (C) 2014  Joshua Branson

;; Author: Joshua Branson <jbranso@purdue.edu>
;; Keywords:

;; this makes C-n add a new line if point is at the end of the buffer. that you you don't
;; have to use return if you don't want to.

;; this version of emacs does not have a package manager
;; this next line needs to be there! It will prompt you to update packages.

;;(keyboard-translate ?\C-x ?\M-x) ;;make C-x mean M-x
;;(keyboard-translate ?\C-t ?\C-x) ;;make C-t mean C-x
(tool-bar-mode -1)
(menu-bar-mode -1)
;; put numbers on the side of the editor
(global-linum-mode 1)
;; this is an alternative to skeletons
;;(yas-global-mode 1)
;;change yes or no to y or n
(fset 'yes-or-no-p 'y-or-n-p)

;; This tells emacs that I do not put two spaces between sentences.
;; Though I'd like to start doing that. Perhaps I could rebind SPC to recognize when I'm ending a sentence, and when I do end a sentence, it will insert 2 spaces instead of 1!
(setq sentence-end-double-space nil)

(require 'package)
;; emacs loads all the packages you've installed with M-x packages-list-packages in the next line
(package-initialize)
(setq package-archives
      ;; gnu elpa contains packages that the FSF endorses. This means that it has a GPL compatible license, and all the authors of the code grant GNU copyright to their code.
      '(("gnu" . "http://elpa.gnu.org/packages/")
	;; this repo allows users to create accounts and uploads packages. These packages can be outdated, but typically stable.
	("marmalade" . "http://marmalade-repo.org/packages/")
	;;melpa is like a git for packages. With melpa, package maintainers upload their code, and melpa regulary compiles the code for whoever wants the package. It's packages can be really up to date, and slightly unstable.
	("melpa" . "http://melpa.org/packages/")))
;; this sets up the packages I have installed.

(helm-mode t)
(helm :sources '(helm-source-recentf
		 helm-source-buffers-list
		 helm-source-findutils
		 helm-source-bookmarks
		 ;;helm-source-ls-git
		 ))

(setq word-wrap t)
;;default keybindings for org-mode. I added these myself. They make any file that ends in .org, be opened in org mode.
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; set the font size... This species a font size of 14 pt
(set-face-attribute 'default nil :height 140)

(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)

;; turn on Semantic
(semantic-mode 1)
;; let's define a function which adds semantic as a suggestion backend to auto complete
;; and hook this function to c-mode-common-hook
(defun my:add-semantic-to-autocomplete()
  (add-to-list 'ac-sources 'ac-source-semantic))

;; the following lines must be before init loads my hooks, because my hooks
;; change some viper commands based upon what file is loaded.
;; For example, my org-mode-hook binds "ct" to (org-todo).
(setq viper-mode t)
(require 'viper)

;;(require 'modal-mode)
;;(setq default-major-mode 'modal-fundamental-mode)
;;(modal-mode 1)
;;(when window-system
;; (modal-mode-line-background-mode 1))
;;;   ;;;
;;;   ;;; end modal-mode setup


(setq user-full-name "Joshua Branson"
      user-mail-address "jbranso@purdue.edu")

;;the default char count that auto-fill-mode will auto-insert a new-line
;;this next line should be a if windows use a larger value. If not then use this value.
(setq-default fill-column 108)
(setq next-line-add-newlines t)


(prefer-coding-system 'utf-8)
(when (display-graphic-p)
  (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING)))

;;yes I do want to kill this shell, even though it has a process attached to it.
(setq kill-buffer-query-functions
      (remq 'process-kill-buffer-query-function
	    kill-buffer-query-functions))

;;setq variables
;; these are some basic emacs configurations that I like
;; don't show the startup screen
(setq inhibit-startup-message t)
;;stop making backup files
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

;; show matching parenthesis
(show-paren-mode t)

;;(ido-mode t)
(ido-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-create-new-buffer 'always)
(setq ido-use-filename-at-point 'guess)
(setq ido-auto-merge-delay-time 1.0)
(setq ido-cannot-complete-command (quote ido-next-match))
(setq ido-enable-regexp t)
;;this is so helpful!!!! you need to enable ido fuzzy matching
(setq ido-enable-flex-matching t)
(setq ido-enable-tramp-completion t)
(setq ido-ignore-buffers (quote ("\*scratch\*" "\*Completions\*" "\*Messages\*" "\*Compile-Log\*" "\*help\*" "*.vr" "*.tp" "*.toc" "*.pg" "*.log" "*.ky" "*.fn" "*.cp" "*.aux" "\\` ")))
(setq ido-ignore-files (quote ("*.vr" "*.toc" "*.tp" "*.pg" "*.log" "*.ky" "*.fn" "*.cp" "*.aux" "\\`CVS/" "\\`#" "\\`.#" "\\`\\.\\./" "\\`\\./")))
(setq ido-max-dir-file-cache 200)
(setq ido-max-work-directory-list 100)
(setq ido-max-work-file-list 20)

;; tell emacs where my agenda file is
(setq org-agenda-files
      (quote
       ("~/documents/things_to_do.org")))

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

;; let emacs use the os clipboard
(setq x-select-enable-primary t)
