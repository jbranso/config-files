;; Setting up semantic mode.
;; This is where I'm getting all of this info from http://alexott.net/en/writings/emacs-devenv/EmacsCedet.html

;; make semantic integrate with the imenu package.
(defun my-semantic-hook ()
  (imenu-add-to-menubar "TAGS"))
(add-hook 'semantic-init-hooks 'my-semantic-hook)

;; specify all the semantic submodules you want to use.
(setq semantic-default-submodes
      (quote
       (global-semantic-highlight-func-mode
        global-semantic-decoration-mode
        global-semantic-idle-completions-mode
        global-semantic-idle-scheduler-mode
        global-semanticdb-minor-mode
        global-semantic-idle-summary-mode
        global-semantic-mru-bookmark-mode
        ;;this will put up triangles on the fringes where I can fold code
        ;; I can also do this with senator-fold-tag
        global-semantic-tag-folding-mode
        ;; this is not being found
        ;; global-cedet-m3-minor-mode
        global-semantic-idle-local-symbol-highlight-mode)))


(semantic-mode 1)

(require 'semantic/bovine/gcc)

;; if I'm to use semantic, then I need to enable global ede mode.
(global-ede-mode t)

;; I need te tell semantic where my projects are.
(ede-cpp-root-project "Test"
                      :name "Test Project"
                      :file "~/programming/c/Makefile"
                      :include-path '("/"
                                      ;; I can specify more include paths here with
                                      ;; "/path/to/wherever/"
                                      ;; if the path is /libs/ then that really means ~/programming/c/Makefile/libs
                                      )
                      ;; this next one tells cedet where to look for system header files.
                      ;; :system-include-path '("~/exp/include")
                      :spp-table '(("isUnix" . "")
                                   ("BOOST_TEST_DYN_LINK" . "")))

;; this hook is not working. Emacs does not like it.
(defun my-cedet-hook-for-c ()
  (local-set-key [(control return)] 'semantic-ia-complete-symbol)
  (local-set-key "\C-c?" 'semantic-ia-complete-symbol-menu)
  ;;(local-set-key "\C-c>" 'semantic-complete-analyze-inline)
  ;;(local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)
  ;;(local-set-key "." 'semantic-complete-self-insert)
  ;;(local-set-key ">" 'semantic-complete-self-insert)
  ;; ac-omni-completion-sources is made buffer local so
  ;; you need to add it to a mode hook to activate on
  ;; whatever buffer you want to use it with.  This
  ;; example uses C mode (as you probably surmised).

  ;; auto-complete.el expects ac-omni-completion-sources to be
  ;; a list of cons cells where each cell's car is a regex
  ;; that describes the syntactical bits you want AutoComplete
  ;; to be aware of. The cdr of each cell is the source that will
  ;; supply the completion data.  The following tells autocomplete
  ;; to begin completion when you type in a . or a ->

  (add-to-list 'ac-omni-completion-sources
               (cons "\\." '(ac-source-semantic)))
  (add-to-list 'ac-omni-completion-sources
               (cons "->" '(ac-source-semantic)))

  ;; ac-sources was also made buffer local in new versions of
  ;; autocomplete.  In my case, I want AutoComplete to use
  ;; semantic and yasnippet (order matters, if reversed snippets
  ;; will appear before semantic tag completions).

  (add-to-list ac-sources '(ac-source-semantic)))
;;(add-hook 'c-mode-common-hook 'my-cedet-hook-for-c)

;;setting up ac
(require 'auto-complete)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

;; (setq ac-sources '(ac-source-yasnippet
;;ac-source-ispell))

(provide 'init-cedet)
