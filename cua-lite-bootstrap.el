;;; @(#) cua-lite-bootstrap.el -- bootstrap for cua-lite
;;; @(#) $Id: cua-lite-bootstrap.el,v 1.1 2001/07/10 00:19:28 jcasa Exp $

;; This file is not part of Emacs

;; Copyright (C) 2001 by Joseph L. Casadonte Jr.
;; Author:          Joe Casadonte (emacs@northbound-train.com)
;; Maintainer:      Joe Casadonte (emacs@northbound-train.com)
;; Created:         June 30, 2001
;; Keywords:        CUA emulator
;; Latest Version:  http://www.northbound-train.com/emacs.html

;; COPYRIGHT NOTICE

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:
;;
;;  cua-lite is a CUA emulator package for Emacs.  cua-lite-bootstrap
;;  is a bootstrap program for cua-lite.  Its purpose is to define
;;  some autoload's for cua-lite, define a hotkey to toggle cua-lite
;;  on and off, and, optionally, load cua-lite and turn it on.  By
;;  having this bootstrap file, which has very little resource
;;  demands, I hope to encourage people to have cua-lite around and
;;  available for use with as little effort as possible.  It can even
;;  be included in site files easily enough.

;;; Installation:
;;
;;  Put this file on your Emacs-Lisp load path and add the following to
;;  your ~/.emacs startup file
;;
;;     (require 'cua-lite-bootstrap)
;;
;;  To add a directory to your load-path, use something like the following:
;;
;;      (add-to-list 'load-path (expand-file-name "/some/load/path"))

;;; Usage:
;;
;;  There's nothing really to use here.  The only thing you can do is
;;  customize a few variables.

;;; Customization:
;;
;;  M-x `cua-lite-bootstrap-customization' to customize all package options.
;;
;;  The following variables can be customized:
;;
;;  o `cua-lite-auto-start'
;;    Boolean used to determine if 'cua-lite' is automatically loaded and
;;    turned on.
;;
;;  o `cua-lite-toggle-hotkey'
;;    Hotkey used to toggle 'cua-lite' on & off

;;; To Do:
;;
;;  o Nothing, at the moment.

;;; Comments:
;;
;;  Any comments, suggestions, bug reports or upgrade requests are welcome.
;;  Please send them to Joe Casadonte (emacs@northbound-train.com).
;;
;;  This version of cua-lite-bootstrap was developed and tested with
;;  NTEmacs 20.7.1 under Windows 2000 & NT 4.0 and Emacs 20.7.1 under
;;  Linux (RH7).  Please, let me know if it works with other OS and
;;  versions of Emacs.

;;; Change Log:
;;
;;  see http://www.northbound-train.com/emacs/cua-lite-bootstrap.log

;;; **************************************************************************
;;; **************************************************************************
;;; **************************************************************************
;;; **************************************************************************
;;; **************************************************************************
;;; Code:

(eval-when-compile
  (defvar byte-compile-dynamic nil) ; silence the old byte-compiler
  (set (make-local-variable 'byte-compile-dynamic) t)
  (autoload 'cua-lite "cua-lite" "Enable or disable 'cua-lite' mode." t))

;;; **************************************************************************
;;; ***** customization routines
;;; **************************************************************************
(defgroup cua-lite nil
  "Emulate CUA bindings."
  :group 'editing-basics
  :group 'convenience)

;; ---------------------------------------------------------------------------
(defcustom cua-lite-auto-start nil
  "Signifies whether or not to turn 'cua-lite' on automatically.

t - 'cua-lite' is enabled as soon as the file is loaded
nil - 'cua-lite' is not enabled until explicitly requested

By default this is set to NIL to encourage people to keep this package
handy for those of us who want to use it."
  :type 'boolean
  :group 'cua-lite)

;; ---------------------------------------------------------------------------
(defcustom cua-lite-toggle-hotkey nil
  "String representing a keystroke to be bound to the command `cua-lite'.

Provided as a convenience to bootstrap users, to allow the mode to be
easily toggled on and off.  The format of the string should be
compatable with `read-kbd-macro', summarized as follows (copied from
`edmacro-mode'):

 o A word in angle brackets, e.g., <return>, <down>, or <f1>, represents
   a function key.  (Note that in the standard configuration, the
   function key <return> and the control key RET are synonymous.)
   You can use angle brackets on the words RET, SPC, etc., but they
   are not required there.

 * Keys can be written by their ASCII code, using a backslash followed
   by up to six octal digits.  This is the only way to represent keys
   with codes above \377.

 * One or more prefixes M- (meta), C- (control), S- (shift), A- (alt),
   H- (hyper), and s- (super) may precede a character or key notation.
   For function keys, the prefixes may go inside or outside of the
   brackets:  C-<down> = <C-down>.  The prefixes may be written in
   any order:  M-C-x = C-M-x.

   Prefixes are not allowed on multi-key words, e.g., C-abc, except
   that the Meta prefix is allowed on a sequence of digits and optional
   minus sign:  M--123 = M-- M-1 M-2 M-3.

 * The `^' notation for control characters also works:  ^M = C-m."
  :type 'string
  :group 'cua-lite)

;;; **************************************************************************
;;; ***** version related routines
;;; **************************************************************************
(defconst cua-lite-bootstrap-version
  "$Revision: 1.1 $"
  "Version number for 'cua-lite-bootstrap' package.")

;; ---------------------------------------------------------------------------
(defun cua-lite-bootstrap-version-number ()
  "Return 'cua-lite-bootstrap' version number."
  (string-match "[0123456789.]+" cua-lite-bootstrap-version)
  (match-string 0 cua-lite-bootstrap-version))

;; ---------------------------------------------------------------------------
(defun cua-lite-bootstrap-display-version ()
  "Display 'cua-lite-bootstrap' version."
  (interactive)
  (message "Package 'cua-lite-bootstrap' version <%s>." (cua-lite-bootstrap-version-number)))

;;; **************************************************************************
;;; ***** set up autoloads and possibly bind hotkey & start cua-lite
;;; **************************************************************************
(autoload 'cua-lite "cua-lite" "Enable or disable 'cua-lite' mode." t)

(when cua-lite-toggle-hotkey
	(global-set-key (read-kbd-macro cua-lite-toggle-hotkey) 'cua-lite))

(when cua-lite-auto-start
  (cua-lite 1))

;;; **************************************************************************
;;; ***** we're done
;;; **************************************************************************
(provide 'cua-lite-bootstrap)

;;; cua-lite-bootstrap.el ends here
;;; **************************************************************************
;;;; *****  EOF  *****  EOF  *****  EOF  *****  EOF  *****  EOF  *************
