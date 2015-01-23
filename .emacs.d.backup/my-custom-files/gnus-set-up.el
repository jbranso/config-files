;; nnimap means imap apparently.
;; To make Gnus work, all you have to do is eval the next lisp list.
;; Then in gnus press t
;; I do not seem to be able to send mail though...
(setq gnus-select-method '(nnimap "purdue"
				  (nnimap-address "mymail.purdue.edu")
				  (nnimap-server-port 993)
				  (nnimap-stream ssl)))

(setq smtpmail-default-smtp-server "smtp.purdue.edu")
(setq send-mail-function 'smtpmail-send-it)
(setq message-send-mail-function 'smtpmail-send-it)

(setq smtpmail-auth-credentials '(("mymail.purdue.edu" "993" "jbranso" "PourOutAll4God!")))
(setq smtpmail-starttls-credentials '(("smtp.purdue.edu" "465" nil nil)))

;;(setq mail-sources '((pop :server "bransoj@hotmail.com"
;; :user "bransoj"
;;			  :password "babbages")))
