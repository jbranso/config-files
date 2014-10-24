;;; setq.el --- Setting variables                    -*- lexical-binding: t; -*-

;; Copyright (C) 2014  Joshua Branson

;; Author: Joshua Branson <jbranso@purdue.edu>
;; Keywords:

;; this makes C-n add a new line if point is at the end of the buffer. that you you don't
;; have to use return if you don't want to.
(setq next-line-add-newlines t)

;;(setq dired-omit-files
;;      (concat dired-omit-files "\\|^INDEX$\\|-t\\.tex$"))


;; this lets emacs package system download the latest and greatest org and org-contrib packages
;; this version of emacs does not have a package manager
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

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

;; let emacs use the os clipboard
(setq x-select-enable-primary t)
