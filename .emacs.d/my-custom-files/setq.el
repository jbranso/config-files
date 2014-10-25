;;; setq.el --- Setting variables                    -*- lexical-binding: t; -*-

;; Copyright (C) 2014  Joshua Branson

;; Author: Joshua Branson <jbranso@purdue.edu>
;; Keywords:

;; this makes C-n add a new line if point is at the end of the buffer. that you you don't
;; have to use return if you don't want to.
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
(setq ido-enable-flex-matching t)
(setq ido-create-new-buffer 'always)
(setq ido-use-filename-at-point 'guess)
(setq ido-auto-merge-delay-time 1.0)
(setq ido-cannot-complete-command (quote ido-next-match))
(setq ido-enable-regexp t)
;;this is so helpful!!!! you need to enable ido fuzzy matching
(setq ido-enable-flex-matching t)
(setq ido-enable-tramp-completion t)
(setq ido-ignore-buffers (quote ("\*scratch\*" "\*Backtrace\*" "\*Completions\*" "\*Messages\*" "\*Compile-Log\*" "\*help\*" "*.vr" "*.tp" "*.toc" "*.pg" "*.log" "*.ky" "*.fn" "*.cp" "*.aux" "\\` ")))
(setq ido-ignore-files (quote ("*.vr" "*.toc" "*.tp" "*.pg" "*.log" "*.ky" "*.fn" "*.cp" "*.aux" "\\`CVS/" "\\`#" "\\`.#" "\\`\\.\\./" "\\`\\./")))
(setq ido-max-dir-file-cache 200)
(setq ido-max-work-directory-list 100)
(setq ido-max-work-file-list 20)
(ido-mode 1)

;; the following lines must be before init loads my hooks, because my hooks
;; change some viper commands based upon what file is loaded.
;; For example, my org-mode-hook binds "ct" to (org-todo).
(require 'viper)
(setq viper-mode t)
(require 'ace-jump-mode)
;;(require 'evil)
;;(evil-mode 1)

;;(setq dired-omit-files
;;      (concat dired-omit-files "\\|^INDEX$\\|-t\\.tex$"))


;; this lets emacs package system download the latest and greatest org and org-contrib packages
;; this version of emacs does not have a package manager
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

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
