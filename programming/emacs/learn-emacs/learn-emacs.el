;; learn-emacs.el --- implementation of Tetris for Emacs

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

(defgroup learn-emacs nil
  "Play a game of Learn-Emacs."
  :prefix "learn-emacs-"
  :group 'games)

(defcustom learn-emacs-use-glyphs t
  "Non-nil means use glyphs when available."
  :group 'learn-emacs
  :type 'boolean)

(defcustom learn-emacs-use-color t
  "Non-nil means use color when available."
  :group 'learn-emacs
  :type 'boolean)

(defcustom learn-emacs-draw-border-with-glyphs t
  "Non-nil means draw a border even when using glyphs."
  :group 'learn-emacs
  :type 'boolean)

(defcustom learn-emacs-default-tick-period 0.3
  "The default time taken for a shape to drop one row."
  :group 'learn-emacs
  :type 'number)

(defcustom learn-emacs-update-speed-function
  'learn-emacs-default-update-speed-function
  "Function run whenever the Learn-Emacs score changes.
Called with two arguments: (SHAPES ROWS)
SHAPES is the number of shapes which have been dropped.
ROWS is the number of rows which have been completed.

If the return value is a number, it is used as the timer period."
  :group 'learn-emacs
  :type 'function)

(defcustom learn-emacs-mode-hook nil
  "Hook run upon starting Learn-Emacs."
  :group 'learn-emacs
  :type 'hook)

(defcustom learn-emacs-tty-colors
  ["blue" "white" "yellow" "magenta" "cyan" "green" "red"]
  "Vector of colors of the various shapes in text mode."
  :group 'learn-emacs
  :type '(vector (color :tag "Shape 1")
		 (color :tag "Shape 2")
		 (color :tag "Shape 3")
		 (color :tag "Shape 4")
		 (color :tag "Shape 5")
		 (color :tag "Shape 6")
		 (color :tag "Shape 7")))

(defcustom learn-emacs-x-colors
  [[0 0 1] [0.7 0 1] [1 1 0] [1 0 1] [0 1 1] [0 1 0] [1 0 0]]
  "Vector of colors of the various shapes."
  :group 'learn-emacs
  :type 'sexp)

(defcustom learn-emacs-buffer-name "*Learn-Emacs*"
  "Name used for Learn-Emacs buffer."
  :group 'learn-emacs
  :type 'string)

(defcustom learn-emacs-buffer-width 30
  "Width of used portion of buffer."
  :group 'learn-emacs
  :type 'number)

(defcustom learn-emacs-buffer-height 22
  "Height of used portion of buffer."
  :group 'learn-emacs
  :type 'number)

(defcustom learn-emacs-width 10
  "Width of playing area."
  :group 'learn-emacs
  :type 'number)

(defcustom learn-emacs-height 20
  "Height of playing area."
  :group 'learn-emacs
  :type 'number)

(defcustom learn-emacs-top-left-x 3
  "X position of top left of playing area."
  :group 'learn-emacs
  :type 'number)

(defcustom learn-emacs-top-left-y 1
  "Y position of top left of playing area."
  :group 'learn-emacs
  :type 'number)

(defvar learn-emacs-next-x (+ (* 2 learn-emacs-top-left-x) learn-emacs-width)
  "X position of next shape.")

(defvar learn-emacs-next-y learn-emacs-top-left-y
  "Y position of next shape.")

(defvar learn-emacs-score-x learn-emacs-next-x
  "X position of score.")

(defvar learn-emacs-score-y (+ learn-emacs-next-y 6)
  "Y position of score.")

;; It is not safe to put this in /tmp.
;; Someone could make a symlink in /tmp
;; pointing to a file you don't want to clobber.
(defvar learn-emacs-score-file "learn-emacs-scores"
  ;; anybody with a well-connected server want to host this?
					;(defvar learn-emacs-score-file "/anonymous@ftp.pgt.com:/pub/cgw/learn-emacs-scores"
  "File for holding high scores.")

;; ;;;;;;;;;;;;; display options ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar learn-emacs-blank-options
  '(((glyph colorize)
     (t ?\040))
    ((color-x color-x)
     (mono-x grid-x)
     (color-tty color-tty))
    (((glyph color-x) [0 0 0])
     (color-tty "black"))))

(defvar learn-emacs-cell-options
  '(((glyph colorize)
     (emacs-tty ?O)
     (t ?\040))
    ((color-x color-x)
     (mono-x mono-x)
     (color-tty color-tty)
     (mono-tty mono-tty))
    ;; color information is taken from learn-emacs-x-colors and learn-emacs-tty-colors
    ))

(defvar learn-emacs-border-options
  '(((glyph colorize)
     (t ?\+))
    ((color-x color-x)
     (mono-x grid-x)
     (color-tty color-tty))
    (((glyph color-x) [0.5 0.5 0.5])
     (color-tty "white"))))

(defvar learn-emacs-space-options
  '(((t ?\040))
    nil
    nil))

;; ;;;;;;;;;;;;; constants ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defconst learn-emacs-shapes
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

;;the scoring rules were taken from "xlearn-emacs".  Blocks score differently
;;depending on their rotation

(defconst learn-emacs-shape-scores
  [[6] [6 7 6 7] [6 7 6 7] [6 7] [6 7] [5 5 6 5] [5 8]] )

(defconst learn-emacs-shape-dimensions
  [[2 2] [3 2] [3 2] [3 2] [3 2] [3 2] [4 1]])

(defconst learn-emacs-blank 7)

(defconst learn-emacs-border 8)

(defconst learn-emacs-space 9)

(defun learn-emacs-default-update-speed-function (_shapes rows)
  (/ 20.0 (+ 50.0 rows)))

;; ;;;;;;;;;;;;; variables ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar learn-emacs-shape 0)
(defvar learn-emacs-rot 0)
(defvar learn-emacs-next-shape 0)
(defvar learn-emacs-n-shapes 0)
(defvar learn-emacs-n-rows 0)
(defvar learn-emacs-score 0)
(defvar learn-emacs-pos-x 0)
(defvar learn-emacs-pos-y 0)
(defvar learn-emacs-paused nil)

(make-variable-buffer-local 'learn-emacs-shape)
(make-variable-buffer-local 'learn-emacs-rot)
(make-variable-buffer-local 'learn-emacs-next-shape)
(make-variable-buffer-local 'learn-emacs-n-shapes)
(make-variable-buffer-local 'learn-emacs-n-rows)
(make-variable-buffer-local 'learn-emacs-score)
(make-variable-buffer-local 'learn-emacs-pos-x)
(make-variable-buffer-local 'learn-emacs-pos-y)
(make-variable-buffer-local 'learn-emacs-paused)

;; ;;;;;;;;;;;;; keymaps ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar learn-emacs-mode-map
  (let ((map (make-sparse-keymap 'learn-emacs-mode-map)))
    (define-key map "n"		'learn-emacs-start-game)
    (define-key map "q"		'learn-emacs-end-game)
    (define-key map "p"		'learn-emacs-pause-game)

    (define-key map " "		'learn-emacs-move-bottom)
    (define-key map [left]	'learn-emacs-move-left)
    (define-key map [right]	'learn-emacs-move-right)
					;    (define-key map [up]	'learn-emacs-rotate-prev)
					;    (define-key map [down]	'learn-emacs-rotate-next)
    map))

(defvar learn-emacs-null-map
  (let ((map (make-sparse-keymap 'learn-emacs-null-map)))
    (define-key map "n"		'learn-emacs-start-game)
    map))

;; ;;;;;;;;;;;;;;;; game functions ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun learn-emacs-display-options ()
  (let ((options (make-vector 256 nil)))
    (dotimes (c 256)
      (aset options c
	    (cond ((= c learn-emacs-blank)
                   learn-emacs-blank-options)
                  ((and (>= c 0) (<= c 6))
		   (append
		    learn-emacs-cell-options
		    `((((glyph color-x) ,(aref learn-emacs-x-colors c))
		       (color-tty ,(aref learn-emacs-tty-colors c))
		       (t nil)))))
                  ((= c learn-emacs-border)
                   learn-emacs-border-options)
                  ((= c learn-emacs-space)
                   learn-emacs-space-options)
                  (t
                   '(nil nil nil)))))
    options))

(defun learn-emacs-get-tick-period ()
  (if (boundp 'learn-emacs-update-speed-function)
      (let ((period (apply learn-emacs-update-speed-function
			   learn-emacs-n-shapes
			   learn-emacs-n-rows nil)))
	(and (numberp period) period))))

(defun learn-emacs-get-shape-cell (block)
  (aref (aref  (aref learn-emacs-shapes
                     learn-emacs-shape) learn-emacs-rot)
        block))

(defun learn-emacs-shape-width ()
  (aref (aref learn-emacs-shape-dimensions learn-emacs-shape) 0))

(defun learn-emacs-shape-rotations ()
  (length (aref learn-emacs-shapes learn-emacs-shape)))

(defun learn-emacs-draw-score ()
  (let ((strings (vector (format "Shapes: %05d" learn-emacs-n-shapes)
			 (format "Rows:   %05d" learn-emacs-n-rows)
			 (format "Score:  %05d" learn-emacs-score))))
    (dotimes (y 3)
      (let* ((string (aref strings y))
             (len (length string)))
        (dotimes (x len)
          (gamegrid-set-cell (+ learn-emacs-score-x x)
                             (+ learn-emacs-score-y y)
                             (aref string x)))))))

(defun learn-emacs-update-score ()
  (learn-emacs-draw-score)
  (let ((period (learn-emacs-get-tick-period)))
    (if period (gamegrid-set-timer period))))

(defun learn-emacs-new-shape ()
  (setq learn-emacs-shape learn-emacs-next-shape)
  (setq learn-emacs-rot 0)
  (setq learn-emacs-next-shape (random 7))
  (setq learn-emacs-pos-x (/ (- learn-emacs-width (learn-emacs-shape-width)) 2))
  (setq learn-emacs-pos-y 0)
  (if (learn-emacs-test-shape)
      (learn-emacs-end-game)
    (learn-emacs-draw-shape)
    (learn-emacs-draw-next-shape)
    (learn-emacs-update-score)))

(defun learn-emacs-draw-next-shape ()
  (dotimes (x 4)
    (dotimes (y 4)
      (gamegrid-set-cell (+ learn-emacs-next-x x)
                         (+ learn-emacs-next-y y)
                         learn-emacs-blank)))
  (dotimes (i 4)
    (let ((learn-emacs-shape learn-emacs-next-shape)
          (learn-emacs-rot 0))
      (gamegrid-set-cell (+ learn-emacs-next-x
                            (aref (learn-emacs-get-shape-cell i) 0))
                         (+ learn-emacs-next-y
                            (aref (learn-emacs-get-shape-cell i) 1))
                         learn-emacs-shape))))

(defun learn-emacs-draw-shape ()
  (dotimes (i 4)
    (let ((c (learn-emacs-get-shape-cell i)))
      (gamegrid-set-cell (+ learn-emacs-top-left-x
                            learn-emacs-pos-x
                            (aref c 0))
                         (+ learn-emacs-top-left-y
                            learn-emacs-pos-y
                            (aref c 1))
                         learn-emacs-shape))))

(defun learn-emacs-erase-shape ()
  (dotimes (i 4)
    (let ((c (learn-emacs-get-shape-cell i)))
      (gamegrid-set-cell (+ learn-emacs-top-left-x
                            learn-emacs-pos-x
                            (aref c 0))
                         (+ learn-emacs-top-left-y
                            learn-emacs-pos-y
                            (aref c 1))
                         learn-emacs-blank))))

(defun learn-emacs-test-shape ()
  (let ((hit nil))
    (dotimes (i 4)
      (unless hit
        (setq hit
              (let* ((c (learn-emacs-get-shape-cell i))
                     (xx (+ learn-emacs-pos-x
                            (aref c 0)))
                     (yy (+ learn-emacs-pos-y
                            (aref c 1))))
                (or (>= xx learn-emacs-width)
                    (>= yy learn-emacs-height)
                    (/= (gamegrid-get-cell
                         (+ xx learn-emacs-top-left-x)
                         (+ yy learn-emacs-top-left-y))
                        learn-emacs-blank))))))
    hit))

(defun learn-emacs-full-row (y)
  (let ((full t))
    (dotimes (x learn-emacs-width)
      (if (= (gamegrid-get-cell (+ learn-emacs-top-left-x x)
                                (+ learn-emacs-top-left-y y))
             learn-emacs-blank)
          (setq full nil)))
    full))

(defun learn-emacs-shift-row (y)
  (if (= y 0)
      (dotimes (x learn-emacs-width)
	(gamegrid-set-cell (+ learn-emacs-top-left-x x)
			   (+ learn-emacs-top-left-y y)
			   learn-emacs-blank))
    (dotimes (x learn-emacs-width)
      (let ((c (gamegrid-get-cell (+ learn-emacs-top-left-x x)
                                  (+ learn-emacs-top-left-y y -1))))
        (gamegrid-set-cell (+ learn-emacs-top-left-x x)
                           (+ learn-emacs-top-left-y y)
			   c)))))

(defun learn-emacs-shift-down ()
  (dotimes (y0 learn-emacs-height)
    (when (learn-emacs-full-row y0)
      (setq learn-emacs-n-rows (1+ learn-emacs-n-rows))
      (cl-loop for y from y0 downto 0 do
               (learn-emacs-shift-row y)))))

(defun learn-emacs-draw-border-p ()
  (or (not (eq gamegrid-display-mode 'glyph))
      learn-emacs-draw-border-with-glyphs))

(defun learn-emacs-init-buffer ()
  (gamegrid-init-buffer learn-emacs-buffer-width
			learn-emacs-buffer-height
			learn-emacs-space)
  (let ((buffer-read-only nil))
    (if (learn-emacs-draw-border-p)
	(cl-loop for y from -1 to learn-emacs-height do
                 (cl-loop for x from -1 to learn-emacs-width do
                          (gamegrid-set-cell (+ learn-emacs-top-left-x x)
                                             (+ learn-emacs-top-left-y y)
                                             learn-emacs-border))))
    (dotimes (y learn-emacs-height)
      (dotimes (x learn-emacs-width)
        (gamegrid-set-cell (+ learn-emacs-top-left-x x)
                           (+ learn-emacs-top-left-y y)
                           learn-emacs-blank)))
    (if (learn-emacs-draw-border-p)
	(cl-loop for y from -1 to 4 do
                 (cl-loop for x from -1 to 4 do
                          (gamegrid-set-cell (+ learn-emacs-next-x x)
                                             (+ learn-emacs-next-y y)
                                             learn-emacs-border))))))

(defun learn-emacs-reset-game ()
  (gamegrid-kill-timer)
  (learn-emacs-init-buffer)
  (setq learn-emacs-next-shape (random 7))
  (setq learn-emacs-shape	0
	learn-emacs-rot	0
	learn-emacs-pos-x	0
	learn-emacs-pos-y	0
	learn-emacs-n-shapes	0
	learn-emacs-n-rows	0
	learn-emacs-score	0
	learn-emacs-paused	nil)
  (learn-emacs-new-shape))

(defun learn-emacs-shape-done ()
  (learn-emacs-shift-down)
  (setq learn-emacs-n-shapes (1+ learn-emacs-n-shapes))
  (setq learn-emacs-score
	(+ learn-emacs-score
	   (aref (aref learn-emacs-shape-scores learn-emacs-shape) learn-emacs-rot)))
  (learn-emacs-update-score)
  (learn-emacs-new-shape))

(defun learn-emacs-update-game (learn-emacs-buffer)
  "Called on each clock tick.
Drops the shape one square, testing for collision."
  (if (and (not learn-emacs-paused)
	   (eq (current-buffer) learn-emacs-buffer))
      (let (hit)
	(learn-emacs-erase-shape)
	(setq learn-emacs-pos-y (1+ learn-emacs-pos-y))
	(setq hit (learn-emacs-test-shape))
	(if hit
	    (setq learn-emacs-pos-y (1- learn-emacs-pos-y)))
	(learn-emacs-draw-shape)
	(if hit
	    (learn-emacs-shape-done)))))

(defun learn-emacs-move-bottom ()
  "Drop the shape to the bottom of the playing area."
  (interactive)
  (unless learn-emacs-paused
    (let ((hit nil))
      (learn-emacs-erase-shape)
      (while (not hit)
        (setq learn-emacs-pos-y (1+ learn-emacs-pos-y))
        (setq hit (learn-emacs-test-shape)))
      (setq learn-emacs-pos-y (1- learn-emacs-pos-y))
      (learn-emacs-draw-shape)
      (learn-emacs-shape-done))))

(defun learn-emacs-move-left ()
  "Move the shape one square to the left."
  (interactive)
  (unless learn-emacs-paused
    (learn-emacs-erase-shape)
    (setq learn-emacs-pos-x (1- learn-emacs-pos-x))
    (if (learn-emacs-test-shape)
        (setq learn-emacs-pos-x (1+ learn-emacs-pos-x)))
    (learn-emacs-draw-shape)))

(defun learn-emacs-move-right ()
  "Move the shape one square to the right."
  (interactive)
  (unless learn-emacs-paused
    (learn-emacs-erase-shape)
    (setq learn-emacs-pos-x (1+ learn-emacs-pos-x))
    (if (learn-emacs-test-shape)
	(setq learn-emacs-pos-x (1- learn-emacs-pos-x)))
    (learn-emacs-draw-shape)))

(defun learn-emacs-end-game ()
  "Terminate the current game."
  (interactive)
  (gamegrid-kill-timer)
  (use-local-map learn-emacs-null-map)
  (gamegrid-add-score learn-emacs-score-file learn-emacs-score))

(defun learn-emacs-start-game ()
  "Start a new game of Learn-Emacs."
  (interactive)
  (learn-emacs-reset-game)
  (use-local-map learn-emacs-mode-map)
  (let ((period (or (learn-emacs-get-tick-period)
		    learn-emacs-default-tick-period)))
    (gamegrid-start-timer period 'learn-emacs-update-game)))

(defun learn-emacs-pause-game ()
  "Pause (or resume) the current game."
  (interactive)
  (setq learn-emacs-paused (not learn-emacs-paused))
  (message (and learn-emacs-paused "Game paused (press p to resume)")))

(defun learn-emacs-active-p ()
  (eq (current-local-map) learn-emacs-mode-map))

(put 'learn-emacs-mode 'mode-class 'special)

(define-derived-mode learn-emacs-mode nil "Learn-Emacs"
  "A mode for playing Learn-Emacs."

  (add-hook 'kill-buffer-hook 'gamegrid-kill-timer nil t)

  (use-local-map learn-emacs-null-map)

  (unless (featurep 'emacs)
    (setq mode-popup-menu
	  '("Learn-Emacs Commands"
	    ["Start new game"	learn-emacs-start-game]
	    ["End game"		learn-emacs-end-game
	     (learn-emacs-active-p)]
	    ["Pause"		learn-emacs-pause-game
	     (and (learn-emacs-active-p) (not learn-emacs-paused))]
	    ["Resume"		learn-emacs-pause-game
	     (and (learn-emacs-active-p) learn-emacs-paused)])))

  (setq show-trailing-whitespace nil)

  (setq gamegrid-use-glyphs learn-emacs-use-glyphs)
  (setq gamegrid-use-color learn-emacs-use-color)

  (gamegrid-init (learn-emacs-display-options)))

;;;###autoload
(defun learn-emacs ()
  "Play the Learn-Emacs game.
Shapes drop from the top of the screen, and the user has to move and
rotate the shape to fit in with those at the bottom of the screen so
as to form complete rows.

learn-emacs-mode keybindings:
   \\<learn-emacs-mode-map>
\\[learn-emacs-start-game]	Starts a new game of Learn-Emacs
\\[learn-emacs-end-game]	Terminates the current game
\\[learn-emacs-pause-game]	Pauses (or resumes) the current game
\\[learn-emacs-move-left]	Moves the shape one square to the left
\\[learn-emacs-move-right]	Moves the shape one square to the right
\\[learn-emacs-rotate-prev]	Rotates the shape clockwise
\\[learn-emacs-rotate-next]	Rotates the shape anticlockwise
\\[learn-emacs-move-bottom]	Drops the shape to the bottom of the playing area

"
  (interactive)

  (select-window (or (get-buffer-window learn-emacs-buffer-name)
		     (selected-window)))
  (switch-to-buffer learn-emacs-buffer-name)
  (gamegrid-kill-timer)
  (learn-emacs-mode)
  (learn-emacs-start-game))

(provide 'learn-emacs)

;;; learn-emacs.el ends here
;;; learn-emacs.el --- a way to learn emacs          -*- lexical-binding: t; -*-
