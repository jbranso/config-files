
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

;;tool-bar-mode is nice for listing the available commands.
(tool-bar-mode -1)
;;(menu-bar-mode -1)
;; put numbers on the side of the editor
(global-linum-mode 1)
;; this is an alternative to skeletons
;;(require 'yasnippet)
(setq yas-snippet-dirs "~/.emacs.d/yasnippet-snippets/")
;;change yes or no to y or n
(fset 'yes-or-no-p 'y-or-n-p)

;;We'll see if this is worth it
;; A classic example would be lambda from various Lisp dialects that many people prefer to replace with the greek letter λ (small lambda). prettify-symbols-mode allows you to achieve this by relying on a simple mapping expressed in the form of an alist that each major mode must initialize (prettify-symbols-alist). Simply put - major modes have to provide the configuration for prettify-symbols-mode.

;; Lisp modes do this via lisp--prettify-symbols-alist:

;; (defconst lisp--prettify-symbols-alist
;;   '(("lambda"  . ?λ)))

;; This means that out of the box only lambda will get replaced. You can, of course, add more mappings for different major modes:


;; (add-hook 'emacs-lisp-mode-hook
;;             (lambda ()
;;               (push '(">=" . ?≥) prettify-symbols-alist)))
(global-prettify-symbols-mode +1)

(require 'package)
;; emacs loads all the packages you've installed with M-x packages-list-packages in the next line
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
;; For important compatibility libraries like cl-lib

(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)
;; this sets up the packages I have installed.
(package-initialize)

(require 'recentf)
(setq recentf-max-saved-items 500)

(require 'helm-config)
(helm-mode t)

;;this is extra features over the default bookmarks+
;; C-x jj jumps you to a bookmark
;; C-x pm creates a bookmark with the current file.
(require 'bookmark+)
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
;; This next line is sooo helpful!!!! It makes tab try to auto-complete for you.
(ac-set-trigger-key "TAB")
(setq ac-sources '(ac-source-semantic
		   ac-source-yasnippet
		   ac-source-ispell
		   ac-source-ispell-fuzzy))

(setq ispell-complete-word-dictionary "usr/bin/aspell")
;;(setq ispell-alternate-dictionary "usr/bin/aspell")

;;speed up flyspell
(setq flyspell-issue-message-flag nil)

;;This package is quite nice. It makes whatever window that currently has focus, be the largest window!
(require 'golden-ratio)
(golden-ratio-mode 1)

;; This next line lets org-mode and refill-mode play together.  Refill-mode automatically calls M-q
;;(refill-paragraph), so you never have to press M-q again. However, you need this next line, tell Refill
;;mode NOT to pull in headings into a paragraph. This not not quite working the it should be. When you press
;;enter on a heading in org-mode, it will merge the current heading with the ones above it, into a
;;paragraph. The setq paragraph-separate seems to be working nicely. If it seems to have fixed it, then I
;;can delete the next line.
;;(setq adaptive-fill-regexp   "[ 	]*\\([-–!|#%;>·•‣⁃◦]+[ 	]*\\)*")
;; this next lines specifes the regexp that seperates paragraphs. If something matches this regexp, then,
;;emacs will assume the thing that matches it is a paragraph seperator. This bit of code is really only for
;;org-mode, and it should make org-mode and refill mode play nicely!
;;(setq     paragraph-separate "[ 	]*$\\|^\\*+.*\|$\\*")
(setq paragraph-separate "[ 	]*$\|^\\*+.*")
(setq org-default-notes-file "~/.emacs.d/notes.org")
(define-key global-map "\C-cc" 'org-capture)

;; turn on Semantic this looks at every file and remembers functions and other good stuff for you to use.
(semantic-mode 1)
;; let's define a function which adds semantic as a suggestion backend to auto complete
;; and hook this function to c-mode-common-hook
(add-to-list 'ac-sources 'ac-source-semantic)

(global-ede-mode t)

;; the following lines must be before init loads my hooks, because my hooks
;; change some viper commands based upon what file is loaded.
;; For example, my org-mode-hook binds "ct" to (org-todo).
;;(setq viper-mode t)
;;(require 'viper)


(setq evil-find-skip-newlines t)
(setq evil-move-cursor-back nil)
;;make the replace cursor red
(setq evil-replace-state-cursor '("red" box))
(setq evil-emacs-state-cursor '("green" box))
(require 'evil)
(evil-mode 1)
(load-file "~/.emacs.d/my-custom-files/evil-changes.el")

;; this is helpful for gnus and rmail I believe.
(setq user-full-name "Joshua Branson"
      user-mail-address "jbranso@purdue.edu")

;;the default char count that auto-fill-mode will auto-insert a new-line
;;this next line should be a if windows use a larger value. If not then use this value.
(setq-default fill-column 108)
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

;; I'm trying to get away from ido-mode
;; (ido-mode 1)
;; (setq ido-enable-flex-matching t)
;; (setq ido-create-new-buffer 'always)
;; (setq ido-use-filename-at-point 'guess)
;; (setq ido-auto-merge-delay-time 1.0)
;; (setq ido-cannot-complete-command (quote ido-next-match))
;; (setq ido-enable-regexp t)
;; ;;this is so helpful!!!! you need to enable ido fuzzy matching
;; (setq ido-enable-flex-matching t)
;; (setq ido-enable-tramp-completion t)
;; (setq ido-ignore-buffers (quote ("\*scratch\*" "\*Completions\*" "\*Messages\*" "\*Compile-Log\*" "\*help\*" "*.vr" "*.tp" "*.toc" "*.pg" "*.log" "*.ky" "*.fn" "*.cp" "*.aux" "\\` ")))
;; (setq ido-ignore-files (quote ("*.vr" "*.toc" "*.tp" "*.pg" "*.log" "*.ky" "*.fn" "*.cp" "*.aux" "\\`CVS/" "\\`#" "\\`.#" "\\`\\.\\./" "\\`\\./")))
;; (setq ido-max-dir-file-cache 200)
;; (setq ido-max-work-directory-list 100)
;; (setq ido-max-work-file-list 20)

;; tell emacs where my agenda file is
(require 'org)
(setq org-agenda-files (quote ("~/programming/org/gtd/gtd.org")))
;; this lets you open links in org mode.
(setq org-return-follows-link t)
;;this will record what time TODO items were finished and the line containing 'note will make org prompt you for a note when you finish
;; a task
(setq org-log-done 'time)

;; toggle follow mode in emacs agenda mode
(setq org-agenda-start-with-follow-mode t)

;; scroll one line at a time (less "jumpy" than defaults)
;; these commands are nice, but they are probably moving my cursor to random spots at times.
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time

(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling

(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

(setq scroll-step 1) ;; keyboard scroll one line at a time

;; let emacs use the os clipboard
(setq x-select-enable-primary t)
