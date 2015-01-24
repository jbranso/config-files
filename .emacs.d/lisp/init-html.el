(require 'web-mode)

(require 'emmet-mode)

(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml?\\'" . web-mode))

(setq web-mode-engines-alist
      '(("php"    . "\\.phtml\\'")
        ("php"  . "\\.php\\.")
        ("django"  . "\\.djhtml\\.")))

(add-hook 'web-mode-hook (lambda ()
                           (flyspell-prog-mode)
                           ;;emmet mode is sooo much better than yas
                           ;; (yas-minor-mode)
                           ;;(yas-reload-all)
                           (emmet-mode)
                           (push '("function" . ?𝆑) prettify-symbols-alist)
                           (push '(">=" . ?≥) prettify-symbols-alist)
                           (push '("<=" . ?≤) prettify-symbols-alist)
                           (aggressive-indent-mode)
                           (auto-fill-mode)))

(add-to-list 'web-mode-ac-sources-alist
             '("html" . (ac-source-html-tag
                         ac-source-html-attribute
                         ac-source-html-attribute-2
                         (ac-source-jquery
                          (ac-source-html-bootstrap+)))))

;; (add-to-list 'ac-sources
;;              ac-source-html-tag
;;              ac-source-html-attribute
;;              ac-source-css-property
;;              ac-source-html-bootstrap
;;              ;;this package has almost nothing in it.
;;              ;; or does it?
;;              ;;ac-source-html-bootstrap+
;;              )
(provide 'init-html)
