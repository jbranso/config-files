;; learn-evil.el --- implementation of Tetris for Emacs

;; Copyright (C) 1997, 2001-2014 Free Software Foundation, Inc.

;; Author: Glynn Clements <glynn@sensei.co.uk>
;; Version: 2.01
;; Created: 1997-08-13
;; Keywords: games

;; This file is part of GNU Emacs.

;; GNU Emacs is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:

(eval-when-compile (require 'cl-lib))

(require 'gamegrid)

;; ;;;;;;;;;;;;; customization variables ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defgroup learn-evil nil
  "Play a game of Learn-Evil."
  :prefix "learn-evil-"
  :group 'games)

(defcustom learn-evil-use-glyphs t
  "Non-nil means use glyphs when available."
  :group 'learn-evil
  :type 'boolean)

(defcustom learn-evil-use-color t
  "Non-nil means use color when available."
  :group 'learn-evil
  :type 'boolean)

(defcustom learn-evil-draw-border-with-glyphs t
  "Non-nil means draw a border even when using glyphs."
  :group 'learn-evil
  :type 'boolean)

(defcustom learn-evil-default-tick-period 0.3
  "The default time taken for a shape to drop one row."
  :group 'learn-evil
  :type 'number)

(defcustom learn-evil-update-speed-function
  'learn-evil-default-update-speed-function
  "Function run whenever the Learn-Evil score changes.
Called with two arguments: (SHAPES ROWS)
SHAPES is the number of shapes which have been dropped.
ROWS is the number of rows which have been completed.

If the return value is a number, it is used as the timer period."
  :group 'learn-evil
  :type 'function)

(defcustom learn-evil-mode-hook nil
  "Hook run upon starting Learn-Evil."
  :group 'learn-evil
  :type 'hook)

(defcustom learn-evil-tty-colors
  ["blue" "white" "yellow" "magenta" "cyan" "green" "red"]
  "Vector of colors of the various shapes in text mode."
  :group 'learn-evil
  :type '(vector (color :tag "Shape 1")
		 (color :tag "Shape 2")
		 (color :tag "Shape 3")
		 (color :tag "Shape 4")
		 (color :tag "Shape 5")
		 (color :tag "Shape 6")
		 (color :tag "Shape 7")))

(defcustom learn-evil-x-colors
  [[0 0 1] [0.7 0 1] [1 1 0] [1 0 1] [0 1 1] [0 1 0] [1 0 0]]
  "Vector of colors of the various shapes."
  :group 'learn-evil
  :type 'sexp)

(defcustom learn-evil-buffer-name "*Learn-Evil*"
  "Name used for Learn-Evil buffer."
  :group 'learn-evil
  :type 'string)

(defcustom learn-evil-buffer-width 150
  "Width of used portion of buffer."
  :group 'learn-evil
  :type 'number)

(defcustom learn-evil-buffer-height 32
  "Height of used portion of buffer."
  :group 'learn-evil
  :type 'number)

(defcustom learn-evil-width 130
  "Width of playing area."
  :group 'learn-evil
  :type 'number)

(defcustom learn-evil-height 30
  "Height of playing area."
  :group 'learn-evil
  :type 'number)

(defcustom learn-evil-top-left-x 3
  "X position of top left of playing area."
  :group 'learn-evil
  :type 'number)

(defcustom learn-evil-top-left-y 1
  "Y position of top left of playing area."
  :group 'learn-evil
  :type 'number)

(defvar learn-evil-next-x (+ (* 2 learn-evil-top-left-x) learn-evil-width)
  "X position of next shape.")

(defvar learn-evil-next-y learn-evil-top-left-y
  "Y position of next shape.")

(defvar learn-evil-score-x learn-evil-next-x
  "X position of score.")

(defvar learn-evil-score-y (+ learn-evil-next-y 6)
  "Y position of score.")

;; It is not safe to put this in /tmp.
;; Someone could make a symlink in /tmp
;; pointing to a file you don't want to clobber.
(defvar learn-evil-score-file "learn-evil-scores"
  ;; anybody with a well-connected server want to host this?
					;(defvar learn-evil-score-file "/anonymous@ftp.pgt.com:/pub/cgw/learn-evil-scores"
  "File for holding high scores.")

;; ;;;;;;;;;;;;; display options ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar learn-evil-blank-options
  '(((glyph colorize)
     (t ?\040))
    ((color-x color-x)
     (mono-x grid-x)
     (color-tty color-tty))
    (((glyph color-x) [0 0 0])
     (color-tty "black"))))

(defvar learn-evil-cell-options
  '(((glyph colorize)
     (emacs-tty ?O)
     (t ?\040))
    ((color-x color-x)
     (mono-x mono-x)
     (color-tty color-tty)
     (mono-tty mono-tty))
    ;; color information is taken from learn-evil-x-colors and learn-evil-tty-colors
    ))

(defvar learn-evil-border-options
  '(((glyph colorize)
     (t ?\+))
    ((color-x color-x)
     (mono-x grid-x)
     (color-tty color-tty))
    (((glyph color-x) [0.5 0.5 0.5])
     (color-tty "white"))))

(defvar learn-evil-space-options
  '(((t ?\040))
    nil
    nil))

;; ;;;;;;;;;;;;; constants ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defconst learn-evil-shapes
  [[[[0  0] [1  0] [0  1] [1  1]]] ; blue square shape 1

   [[[0  0] [1  0] [2  0] [2  1]]
    [[1 -1] [1  0] [1  1] [0  1]]
    [[0 -1] [0  0] [1  0] [2  0]]
    [[1 -1] [2 -1] [1  0] [1  1]]]

   [[[0  0] [1  0] [2  0] [0  1]]
    [[0 -1] [1 -1] [1  0] [1  1]]
    [[2 -1] [0  0] [1  0] [2  0]]
    [[1 -1] [1  0] [1  1] [2  1]]]

   [[[0  0] [1  0] [1  1] [2  1]]
    [[1  0] [0  1] [1  1] [0  2]]]

   [[[1  0] [2  0] [0  1] [1  1]]
    [[0  0] [0  1] [1  1] [1  2]]]

   [[[1  0] [0  1] [1  1] [2  1]]
    [[1  0] [1  1] [2  1] [1  2]]
    [[0  1] [1  1] [2  1] [1  2]]
    [[1  0] [0  1] [1  1] [1  2]]]

   [[[0  0] [1  0] [2  0] [3  0]]
    [[1 -1] [1  0] [1  1] [1  2]]]]
  "Each shape is described by a vector that contains the coordinates of
each one of its four blocks.")

;;the scoring rules were taken from "xlearn-evil".  Blocks score differently
;;depending on their rotation

(defconst learn-evil-shape-scores
  [[6] [6 7 6 7] [6 7 6 7] [6 7] [6 7] [5 5 6 5] [5 8]] )

(defconst learn-evil-shape-dimensions
  [[2 2] ;the square
   [3 2] [3 2] [3 2] [3 2] [3 2]
   [4 1]] ;the red log
  )

(defconst learn-evil-blank 7)

(defconst learn-evil-border 8)

(defconst learn-evil-space 9)

(defun learn-evil-default-update-speed-function (_shapes rows)
  (/ 20.0 (+ 50.0 rows)))

;; ;;;;;;;;;;;;; variables ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar learn-evil-shape 0)
(defvar learn-evil-rot 0)
(defvar learn-evil-next-shape 0)
(defvar learn-evil-n-shapes 0)
(defvar learn-evil-n-rows 0)
(defvar learn-evil-score 0)
(defvar learn-evil-pos-x 10)
(defvar learn-evil-pos-y 10)
(defvar learn-evil-paused nil)

(make-variable-buffer-local 'learn-evil-shape)
(make-variable-buffer-local 'learn-evil-rot)
(make-variable-buffer-local 'learn-evil-next-shape)
(make-variable-buffer-local 'learn-evil-n-shapes)
(make-variable-buffer-local 'learn-evil-n-rows)
(make-variable-buffer-local 'learn-evil-score)
(make-variable-buffer-local 'learn-evil-pos-x)
(make-variable-buffer-local 'learn-evil-pos-y)
(make-variable-buffer-local 'learn-evil-paused)

;; ;;;;;;;;;;;;; keymaps ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar learn-evil-mode-map
  (let ((map (make-sparse-keymap 'learn-evil-mode-map)))
    (define-key map "n"		 'learn-evil-start-game)
    (define-key map "q"		 'learn-evil-end-game)
    (define-key map "p"		 'learn-evil-pause-game)

    (define-key map " "		 'learn-evil-move-bottom)
    (define-key map [left]	 'learn-evil-move-left)
    (define-key map [right]	 'learn-evil-move-right)
    (define-key map "h"          'learn-evil-move-left)
    (define-key map "l"	         'learn-evil-move-right)
    (define-key map "k"          'learn-evil-move-up)
    (define-key map "j"	         'learn-evil-move-down)
					;    (define-key map [up]	'learn-evil-rotate-prev)
					;    (define-key map [down]	'learn-evil-rotate-next)
    map))

(defvar learn-evil-null-map
  (let ((map (make-sparse-keymap 'learn-evil-null-map)))
    (define-key map "n"		'learn-evil-start-game)
    map))

;; ;;;;;;;;;;;;;;;; game functions ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun learn-evil-display-options ()
  (let ((options (make-vector 256 nil)))
    (dotimes (c 256)
      (aset options c
	    (cond ((= c learn-evil-blank)
                   learn-evil-blank-options)
                  ((and (>= c 0) (<= c 6))
		   (append
		    learn-evil-cell-options
		    `((((glyph color-x) ,(aref learn-evil-x-colors c))
		       (color-tty ,(aref learn-evil-tty-colors c))
		       (t nil)))))
                  ((= c learn-evil-border)
                   learn-evil-border-options)
                  ((= c learn-evil-space)
                   learn-evil-space-options)
                  (t
                   '(nil nil nil)))))
    options))

(defun learn-evil-get-tick-period ()
  (if (boundp 'learn-evil-update-speed-function)
      (let ((period (apply learn-evil-update-speed-function
			   learn-evil-n-shapes
			   learn-evil-n-rows nil)))
	(and (numberp period) period))))

(defun learn-evil-get-shape-cell (block)
  (aref (aref  (aref learn-evil-shapes
                     learn-evil-shape) learn-evil-rot)
        block))

(defun learn-evil-shape-width ()
  (aref (aref learn-evil-shape-dimensions learn-evil-shape) 0))

(defun learn-evil-shape-rotations ()
  (length (aref learn-evil-shapes learn-evil-shape)))

(defun learn-evil-draw-score ()
  (let ((strings (vector (format "Shapes: %05d" learn-evil-n-shapes)
			 (format "Rows:   %05d" learn-evil-n-rows)
			 (format "Score:  %05d" learn-evil-score))))
    (dotimes (y 3)
      (let* ((string (aref strings y))
             (len (length string)))
        (dotimes (x len)
          (gamegrid-set-cell (+ learn-evil-score-x x)
                             (+ learn-evil-score-y y)
                             (aref string x)))))))

(defun learn-evil-update-score ()
  (learn-evil-draw-score)
  (let ((period (learn-evil-get-tick-period)))
    (if period (gamegrid-set-timer period))))

(defun learn-evil-new-shape ()
  (setq learn-evil-shape learn-evil-next-shape)
  (setq learn-evil-rot 0)
  (setq learn-evil-next-shape (random 7))
  (setq learn-evil-pos-x (/ (- learn-evil-width (learn-evil-shape-width)) 2))
  (setq learn-evil-pos-y 0)
  (if (learn-evil-test-shape)
      (learn-evil-end-game)
    (learn-evil-draw-shape)
    (learn-evil-draw-next-shape)
    (learn-evil-update-score)))

(defun learn-evil-draw-next-shape ()
  (dotimes (x 4)
    (dotimes (y 4)
      (gamegrid-set-cell (+ learn-evil-next-x x)
                         (+ learn-evil-next-y y)
                         learn-evil-blank)))
  (dotimes (i 4)
    (let ((learn-evil-shape learn-evil-next-shape)
          (learn-evil-rot 0))
      (gamegrid-set-cell (+ learn-evil-next-x
                            (aref (learn-evil-get-shape-cell i) 0))
                         (+ learn-evil-next-y
                            (aref (learn-evil-get-shape-cell i) 1))
                         learn-evil-shape))))

(defun learn-evil-draw-shape ()
  (dotimes (i 4)
    (let ((c (learn-evil-get-shape-cell i)))
      (gamegrid-set-cell (+ learn-evil-top-left-x
                            learn-evil-pos-x
                            (aref c 0))
                         (+ learn-evil-top-left-y
                            learn-evil-pos-y
                            (aref c 1))
                         learn-evil-shape))))

(defun learn-evil-erase-shape ()
  (dotimes (i 4)
    (let ((c (learn-evil-get-shape-cell i)))
      (gamegrid-set-cell (+ learn-evil-top-left-x
                            learn-evil-pos-x
                            (aref c 0))
                         (+ learn-evil-top-left-y
                            learn-evil-pos-y
                            (aref c 1))
                         learn-evil-blank))))

(defun learn-evil-test-shape ()
  (let ((hit nil))
    (dotimes (i 4)
      (unless hit
        (setq hit
              (let* ((c (learn-evil-get-shape-cell i))
                     (xx (+ learn-evil-pos-x
                            (aref c 0)))
                     (yy (+ learn-evil-pos-y
                            (aref c 1))))
                (or (>= xx learn-evil-width)
                    (>= yy learn-evil-height)
                    (/= (gamegrid-get-cell
                         (+ xx learn-evil-top-left-x)
                         (+ yy learn-evil-top-left-y))
                        learn-evil-blank))))))
    hit))

(defun learn-evil-full-row (y)
  (let ((full t))
    (dotimes (x learn-evil-width)
      (if (= (gamegrid-get-cell (+ learn-evil-top-left-x x)
                                (+ learn-evil-top-left-y y))
             learn-evil-blank)
          (setq full nil)))
    full))

(defun learn-evil-shift-row (y)
  (if (= y 0)
      (dotimes (x learn-evil-width)
	(gamegrid-set-cell (+ learn-evil-top-left-x x)
			   (+ learn-evil-top-left-y y)
			   learn-evil-blank))
    (dotimes (x learn-evil-width)
      (let ((c (gamegrid-get-cell (+ learn-evil-top-left-x x)
                                  (+ learn-evil-top-left-y y -1))))
        (gamegrid-set-cell (+ learn-evil-top-left-x x)
                           (+ learn-evil-top-left-y y)
			   c)))))

(defun learn-evil-shift-down ()
  (dotimes (y0 learn-evil-height)
    (when (learn-evil-full-row y0)
      (setq learn-evil-n-rows (1+ learn-evil-n-rows))
      (cl-loop for y from y0 downto 0 do
               (learn-evil-shift-row y)))))

(defun learn-evil-draw-border-p ()
  (or (not (eq gamegrid-display-mode 'glyph))
      learn-evil-draw-border-with-glyphs))

(defun learn-evil-init-buffer ()
  (gamegrid-init-buffer learn-evil-buffer-width
			learn-evil-buffer-height
			learn-evil-space)
  (let ((buffer-read-only nil))
    (if (learn-evil-draw-border-p)
	(cl-loop for y from -1 to learn-evil-height do
                 (cl-loop for x from -1 to learn-evil-width do
                          (gamegrid-set-cell (+ learn-evil-top-left-x x)
                                             (+ learn-evil-top-left-y y)
                                             learn-evil-border))))
    (dotimes (y learn-evil-height)
      (dotimes (x learn-evil-width)
        (gamegrid-set-cell (+ learn-evil-top-left-x x)
                           (+ learn-evil-top-left-y y)
                           learn-evil-blank)))
    (if (learn-evil-draw-border-p)
	(cl-loop for y from -1 to 4 do
                 (cl-loop for x from -1 to 4 do
                          (gamegrid-set-cell (+ learn-evil-next-x x)
                                             (+ learn-evil-next-y y)
                                             learn-evil-border))))))

(defun learn-evil-reset-game ()
  (gamegrid-kill-timer)
  (learn-evil-init-buffer)
  (setq learn-evil-next-shape (random 7))
  (setq learn-evil-shape	0
	learn-evil-rot	0
	learn-evil-pos-x	0
	learn-evil-pos-y	0
	learn-evil-n-shapes	0
	learn-evil-n-rows	0
	learn-evil-score	0
	learn-evil-paused	nil)
  (learn-evil-new-shape))

(defun learn-evil-shape-done ()
  (learn-evil-shift-down)
  (setq learn-evil-n-shapes (1+ learn-evil-n-shapes))
  (setq learn-evil-score
	(+ learn-evil-score
	   (aref (aref learn-evil-shape-scores learn-evil-shape) learn-evil-rot)))
  (learn-evil-update-score)
  (learn-evil-new-shape))

(defun learn-evil-update-game (learn-evil-buffer)
  "Called on each clock tick.
Drops the shape one square, testing for collision."
  (if (and (not learn-evil-paused)
	   (eq (current-buffer) learn-evil-buffer))
      (let (hit)
	(learn-evil-erase-shape)
	(setq learn-evil-pos-y (1+ learn-evil-pos-y))
	(setq hit (learn-evil-test-shape))
	(if hit
	    (setq learn-evil-pos-y (1- learn-evil-pos-y)))
	(learn-evil-draw-shape)
	(if hit
	    (learn-evil-shape-done)))))

(defun learn-evil-move-bottom ()
  "Drop the shape to the bottom of the playing area."
  (interactive)
  (unless learn-evil-paused
    (let ((hit nil))
      (learn-evil-erase-shape)
      (while (not hit)
        (setq learn-evil-pos-y (1+ learn-evil-pos-y))
        (setq hit (learn-evil-test-shape)))
      (setq learn-evil-pos-y (1- learn-evil-pos-y))
      (learn-evil-draw-shape)
      (learn-evil-shape-done))))

(defun learn-evil-move-down ()
  "Move the shape one square to the up."
  (interactive)
  (unless learn-evil-paused
    (learn-evil-erase-shape)
    (setq learn-evil-pos-y (1+ learn-evil-pos-y))
    (if (learn-evil-test-shape)
        (setq learn-evil-pos-y (1- learn-evil-pos-y)))
    (learn-evil-draw-shape)))

(defun learn-evil-move-up ()
  "Move the shape one square to the up."
  (interactive)
  (unless learn-evil-paused
    (learn-evil-erase-shape)
    (setq learn-evil-pos-y (1- learn-evil-pos-y))
    (if (learn-evil-test-shape)
        (setq learn-evil-pos-y (1+ learn-evil-pos-y)))
    (learn-evil-draw-shape)))

(defun learn-evil-move-left ()
  "Move the shape one square to the left."
  (interactive)
  (unless learn-evil-paused
    (learn-evil-erase-shape)
    (setq learn-evil-pos-x (1- learn-evil-pos-x))
    (if (learn-evil-test-shape)
        (setq learn-evil-pos-x (1+ learn-evil-pos-x)))
    (learn-evil-draw-shape)))

(defun learn-evil-move-right ()
  "Move the shape one square to the right."
  (interactive)
  (unless learn-evil-paused
    (learn-evil-erase-shape)
    (setq learn-evil-pos-x (1+ learn-evil-pos-x))
    (if (learn-evil-test-shape)
	(setq learn-evil-pos-x (1- learn-evil-pos-x)))
    (learn-evil-draw-shape)))

(defun learn-evil-end-game ()
  "Terminate the current game."
  (interactive)
  (gamegrid-kill-timer)
  (use-local-map learn-evil-null-map)
  (gamegrid-add-score learn-evil-score-file learn-evil-score))

(defun learn-evil-start-game ()
  "Start a new game of Learn-Evil."
  (interactive)
  (learn-evil-reset-game)
  (use-local-map learn-evil-mode-map)
  (let ((period (or (learn-evil-get-tick-period)
		    learn-evil-default-tick-period)))
    (gamegrid-start-timer period 'learn-evil-update-game)))

(defun learn-evil-pause-game ()
  "Pause (or resume) the current game."
  (interactive)
  (setq learn-evil-paused (not learn-evil-paused))
  (message (and learn-evil-paused "Game paused (press p to resume)")))

(defun learn-evil-active-p ()
  (eq (current-local-map) learn-evil-mode-map))

(put 'learn-evil-mode 'mode-class 'special)

(define-derived-mode learn-evil-mode nil "Learn-Evil"
  "A mode for playing Learn-Evil."

  (add-hook 'kill-buffer-hook 'gamegrid-kill-timer nil t)

  (use-local-map learn-evil-null-map)

  (unless (featurep 'emacs)
    (setq mode-popup-menu
	  '("Learn-Evil Commands"
	    ["Start new game"	learn-evil-start-game]
	    ["End game"		learn-evil-end-game
	     (learn-evil-active-p)]
	    ["Pause"		learn-evil-pause-game
	     (and (learn-evil-active-p) (not learn-evil-paused))]
	    ["Resume"		learn-evil-pause-game
	     (and (learn-evil-active-p) learn-evil-paused)])))

  (setq show-trailing-whitespace nil)

  (setq gamegrid-use-glyphs learn-evil-use-glyphs)
  (setq gamegrid-use-color learn-evil-use-color)

  (gamegrid-init (learn-evil-display-options)))

;;;###autoload
(defun learn-evil ()
  "Play the Learn-Evil game.
Shapes drop from the top of the screen, and the user has to move and
rotate the shape to fit in with those at the bottom of the screen so
as to form complete rows.

learn-evil-mode keybindings:
   \\<learn-evil-mode-map>
\\[learn-evil-start-game]	Starts a new game of Learn-Evil
\\[learn-evil-end-game]	Terminates the current game
\\[learn-evil-pause-game]	Pauses (or resumes) the current game
\\[learn-evil-move-left]	Moves the shape one square to the left
\\[learn-evil-move-right]	Moves the shape one square to the right
\\[learn-evil-rotate-prev]	Rotates the shape clockwise
\\[learn-evil-rotate-next]	Rotates the shape anticlockwise
\\[learn-evil-move-bottom]	Drops the shape to the bottom of the playing area

"
  (interactive)

  (select-window (or (get-buffer-window learn-evil-buffer-name)
		     (selected-window)))
  (switch-to-buffer learn-evil-buffer-name)
  (gamegrid-kill-timer)
  (learn-evil-mode)
  (learn-evil-start-game))

(provide 'learn-evil)

;;; learn-evil.el ends here
;;; learn-evil.el --- a way to learn emacs          -*- lexical-binding: t; -*-
