;; variables.el --- Setting variables                    -*- lexical-binding: t; -*-

;; Copyright (C) 2014  Joshua Branson

;; Author: Joshua Branson <jbranso@purdue.edu>
;; Keywords:

;; this makes C-n add a new line if point is at the end of the buffer. that you you don't
;; have to use return if you don't want to.

;; this version of emacs does not have a package manager
;; this next line needs to be there! It will prompt you to update packages.

;;tool-bar-mode is nice for listing the available commands.
(tool-bar-mode -1)
;;(menu-bar-mode -1)
;; put numbers on the side of the editor
(global-linum-mode 1)

;;change yes or no to y or n
(fset 'yes-or-no-p 'y-or-n-p)

;; this at the moment turns 'lambda' into a very cool looking symbol.
;;I'd like to be able to turn --> and ==> into cool looking arrows. as well as :) into smileys.
(global-prettify-symbols-mode +1)

;;when you press C-v or C-F, scroll one complete page down. Do not scroll nearly one page down.
(setq next-screen-context-lines -1)

;; set the font size... This species a font size of 14 pt
(set-face-attribute 'default nil :height 140)

;; >>>>> package set up >>>>>>>
(require 'package)
(package-initialize)
;; emacs loads all the packages you've installed with M-x packages-list-packages in the next line
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)
;; For important compatibility libraries like cl-lib
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)
;;; >>>> package set up >>>>>>

;;; >>>> set up el.get >>>>
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)
;;;; >>>>> set up elget >>>>>

;; this does not work at all.
;;(require 'aggressive-indent)
;;(global-aggressive-indent-mode 1)
;;(add-to-list 'aggressive-indent-excluded-modes 'html-mode)

;; this is an alternative to skeletons
(require 'yasnippet)
(yas-global-mode 1)
;;(setq yas-snippet-dirs "~/.emacs.d/yasnippet-snippets/")

(require 'recentf)
(setq recentf-max-saved-items 200)

(require 'helm-config)
(helm-mode t)

;;this is extra features over the default bookmarks+
;; C-x jj jumps you to a bookmark
;; C-x pm creates a bookmark with the current file.
(require 'bookmark+)

(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
;; This next line is sooo helpful!!!! It makes tab try to auto-complete for you.
(ac-set-trigger-key "TAB")
(setq ac-sources '(ac-source-yasnippet
		   ac-source-ispell
		   ac-source-ispell-fuzzy))

;; using aspell may be causing problems
;;(setq ispell-complete-word-dictionary "usr/bin/aspell")
;;(setq ispell-alternate-dictionary "usr/bin/aspell")

;;This package is quite nice. It makes whatever window that currently has focus, be the largest window!
(require 'golden-ratio)
(golden-ratio-mode 1)

(require 'git-gutter)
(git-gutter:linum-setup)

;; turn on Semantic this looks at every file and remembers functions and other good stuff for you to use.
(semantic-mode 1)
;; let's define a function which adds semantic as a suggestion backend to auto complete
;; and hook this function to c-mode-common-hook
(add-to-list 'ac-sources 'ac-source-semantic)

;; Since I'm not using this, why enable it?
;;(global-ede-mode t)

(setq evil-find-skip-newlines t)
(setq evil-move-cursor-back nil)
;;make the replace cursor red
(setq evil-replace-state-cursor '("red" box))
(setq evil-emacs-state-cursor '("green" box))

;; >>>>>> evil config >>>>>
(require 'evil)
(evil-mode 1)
(load-file "~/.emacs.d/my-custom-files/evil-changes.el")
;; >>>>> evil config >>>>>>

;;Since I'm not using it, let's not add it.
;;(require 'emmet)

;;the default char count that auto-fill-mode will auto-insert a new-line this next line should be a if
;;windows use a larger value. If not then use this value.  (setq-default fill-column 108)

(setq next-line-add-newlines t)

;;yes I do want to kill this shell, even though it has a process attached to it.
(setq kill-buffer-query-functions
      (remq 'process-kill-buffer-query-function
	    kill-buffer-query-functions))

;;setq variables
;; these are some basic emacs configurations that I like
;; don't show the startup screen
(setq inhibit-startup-message t)
;;Tell emacs where you want to save backups.
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

;; tell emacs to stop making backups
;;(SETQ auto-save-default nil) this one does not work!!
;;(setq make-backup-files nil)

;; show matching parenthesis
(show-paren-mode t)

;; >>>> multiple cursors stuff >>>>
(require 'multiple-cursors)

;; set a cursor on marked text that spans multiple lines
;; I can also probably change the following into viper specific commands for visual mode
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C-c >") 'mc/mark-next-like-this)
(global-set-key (kbd "C-c <") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; >>>> org customizations >>>>> ;;;

;;default keybindings for org-mode. I added these myself. They make any file that ends in .org, be opened in org mode.
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; tell emacs where my agenda file is
(require 'org)

;; This next line lets org-mode and refill-mode play together.  Refill-mode automatically calls M-q
;;(refill-paragraph), so you never have to press M-q again.
;; this next lines specifes the regexp that seperates paragraphs. If something matches this regexp, then,
;;emacs will assume the thing that matches it is a paragraph seperator.
;; if the next line is a bunch of white space OR an org heading, then it seperates paragraphs!
;;(setq paragraph-separate "[ 	]*$\\|^\\*+.*")
;;(setq paragraph-start   "\f\\|[ 	]*$\f\\|[ 	]\\**$")
(setq org-default-notes-file "~/.emacs.d/notes.org")
(define-key global-map "\C-cc" 'org-capture)

(setq org-agenda-files (quote ("~/programming/org/gtd/gtd.org")))
;; this lets you open links in org mode.
(setq org-return-follows-link t)
;;this will record what time TODO items were finished and the line containing 'note will make org prompt you for a note when you finish
;; a task
(setq org-log-done 'time)

;; toggle follow mode in emacs agenda mode
(setq org-agenda-start-with-follow-mode t)

;; >>>>>> org customizations >>>>>>>>

;; scroll one line at a time (less "jumpy" than defaults)
;; these commands are nice, but they are probably moving my cursor to random spots at times.

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time

(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling

(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

(setq scroll-step 1) ;; keyboard scroll one line at a time

;; let emacs use the os clipboard
(setq x-select-enable-primary t)
