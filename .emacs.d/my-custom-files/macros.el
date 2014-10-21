;; macros.el --- some nice macros

;; Copyright (C) 2014

;; Author:  <joshua@arch>
;; Keywords:

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

(fset 'copy-next-html-element
   (lambda (&optional arg) "Keyboard macro."
     (interactive "p")
     (kmacro-exec-ring-item (quote ("ps<[a-z]nnm.sps>cc" 0 "%d")) arg)))

(fset 'copy-last-html-element
   "pb>\C-msm.ncncccn")

(fset 'viper-space
   "\C-z \C-z")

;;it works when you do ce viper-copy line, but you cannot bind it to a key.
(fset 'viper-copy-line
   "ddcP")
