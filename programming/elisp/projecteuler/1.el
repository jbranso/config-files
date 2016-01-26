;;; package --- Summary
;;; Commentary:

;; If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.

;; Find the sum of all the multiples of 3 or 5 below 1000.
;;; Code:

;; I could perhaps use a variable to be what numbers to divide by.  That would mean that the program could change
;; with time.  Perhaps I'll do that when I try to make this better

;;(defvar numbers '(3 5))

"This is a new thing."

<<<<<<< HEAD
This is something else that should be deleted when I press v in the history of magit

Something else that should be changed.

woo hoo I am cool!

=======
>>>>>>> parent of 98ae2ff... another boring addition that I will soon revert.
(defun divisible-by-3 (number)
    "Is the current NUMBER divisible by 3."
    (if (eq (% number 3) 0)
        t
      nil))

(defun divisible-by-5 (number)
    "Is the current NUMBER divisible by 3."
    (if (eq (% number 5) 0)
        t
      nil))

(defvar number 1)
(defvar sum 0)

(while (< number 1000)
  ;;if the number is divisible by 5 or 3
  (when (or (divisible-by-3 number) (divisible-by-5 number))
    (setq sum (+ sum number)))
  (setq number (+ number 1)))

(print number)
(print sum)

;;(provide '1)

;;(load "~/programming/elisp/projecteuler/1.elc" )


;;; 1.el ends here
