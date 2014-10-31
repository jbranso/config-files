;;; evil-changes.el --- My custom evil stuff         -*- lexical-binding: t; -*-

;; Copyright (C) 2014

;; Author:  <joshua@arch>
;; Keywords: wp

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; wooo hooo

;;; Code:

(define-key evil-normal-state-map "s"
  'evil-forward-char)
(define-key evil-normal-state-map "n"
  'evil-backward-char)
(define-key evil-normal-state-map "c" nil)
(define-key evil-motion-state-map "cu" 'universal-argument)
(define-key evil-normal-state-map "ca"
  'execute-extented-command)


(provide 'evil-changes)
;;; evil-changes.el ends here
