;; A function definition can have up to 5 parts
;; 1) the name of the function
;; 2) the arguments that you pass to the function. If none, then ()
;; 3) documentation describing the function.
;; 4) make the function interactive aka. ce can use it.
;; 5) the body of the function

;; my setup functions:

(defun setup-package ()
  "This sets up my package package."
  (interactive)
  '(lambda ()
     (interactive)
     (require 'package)
     (package-initialize)
     ;; emacs loads all the packages you've installed with M-x packages-list-packages in the next line
     (add-to-list 'package-archives
		  '("melpa" . "http://melpa.org/packages/") t)
     ;; For important compatibility libraries like cl-lib
     (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)))

;;delete this after febuary.
;;(defun byte-recompile-emacs-config-files () (interactive)
;;       (when (string-match "\\.el$" (buffer-file-name) 0)
;;eval the current buffer
;;	 (byte-compile-file "/home/joshua/.emacs.d/init.el")
;;	 (byte-recompile-directory "/home/joshua/.emacs.d/my-custom-files")))

;; Usage: emacs -diff file1 file2
(defun command-line-diff (switch)
  (let ((file1 (pop command-line-args-left))
	(file2 (pop command-line-args-left)))
    (ediff file1 file2)))

;; save the current file in the dev server to the soihub live server
(defun save-current-buffer-to-live-server ()
  (interactive)
  ;;do some more stuff
  )

;;this function creates a hot-key M-x gtd that will open my gtd file
(defun gtd ()
  "This command opens ~/things_to_do.org"
  (interactive)
  (find-file "~/programming/org/gtd/gtd.org"))

;; this function will open my init file for me
(defun init-file ()
  "init-file opens ~/.emacs"
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(defun vim ()
  "loads my viper initialization file"
  (interactive)
  (load "~/.emacs.d/viper")
  (find-file "~/.emacs.d/viper"))

;; This file will open rc.lua
(defun rc.lua ()
  "This command opens ~/.config/awesome/rc.lua"
  (interactive)
  (find-file "~/.config/awesome/rc.lua"))

;; This file will open emacs.texi
(defun emacs.texi ()
  "This command opens ~/manuals/cheatsheats/emacs.texi"
  (interactive)
  (find-file "~/manuals/cheatsheats/emacs.texi"))

;; This file will open gawk.texi
(defun gawk.texi ()
  "This command opens ~/manuals/cheatsheats/gawk.texi"
  (interactive)
  (find-file "~/manuals/cheatsheats/gawk.texi"))

;; this function will open macros.el
(defun macros ()
  "init-file opens ~/.emacs.d/"
  (interactive)
  (find-file "~/.emacs.d/my-custom-files/macros.el"))

;; This file will open definitions.el
(defun definitions ()
  "This command opens ~/.emacs.d/definitions.el"
  (interactive)
  (find-file "~/.emacs.d/my-custom-files/definitions.el"))

(defun hooks ()
  "This command opens ~/.emacs.d/hooks.el"
  (interactive)
  (find-file "~/.emacs.d/my-custom-files/hooks.el"))

(defun abbrev ()
  "This command opens ~/.emacs.d/abbrev_defs"
  (interactive)
  (find-file "~/.emacs.d/my-custom-files/abbrev_defs"))

(defun evil ()
  "this command opens ~/.emacs.d/my-custom-files/evil-changes.el"
  (interactive)
  (find-file "~/.emacs.d/my-custom-files/evil-changes.el"))

(defun skeletons ()
  "This command opens ~/.emacs.d/skeletons.el"
  (interactive)
  (find-file "~/.emacs.d/my-custom-files/skeletons.el"))

(defun variables ()
  "This command opens ~/.emacs.d/setq.el"
  (interactive)
  (find-file "~/.emacs.d/my-custom-files/variables.el"))

(defun systemd.texi ()
  "This command opens ~/manuals/systemd.texi"
  (interactive)
  (find-file "~/manuals/systemd.texi"))

;;test awesome
(defun test-awesome ()
  "this run /home/joshua/programming/bash/test-awesome.bash"
  (interactive)
  (start-process "testing-awesome" "test-of-awesome" "test-awesome.bash"))
;; you can use start-process like this:
;; (start-process NAME BUFFER PROGRAM &rest PROGRAM-ARGS))

;;What does this do?
(defun th-rename-tramp-buffer ()
  (when (file-remote-p (buffer-file-name))
    (rename-buffer
     (format "%s:%s"
             (file-remote-p (buffer-file-name) 'method)
             (buffer-name)))))

(add-hook 'find-file-hook
          'th-rename-tramp-buffer)

(defadvice find-file (around th-find-file activate)
  "Open FILENAME using tramp's sudo method if it's read-only."
  (if (and (not (file-writable-p (ad-get-arg 0)))
           (y-or-n-p (concat "File "
                             (ad-get-arg 0)
                             " is read-only.  Open it as root? ")))
      (th-find-file-sudo (ad-get-arg 0))
    ad-do-it))

(defun th-find-file-sudo (file)
  "Opens FILE with root privileges."
  (interactive "F")
  (set-buffer (find-file (concat "/sudo::" file))))
