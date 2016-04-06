;;; Rapid Scheme --- An implementation of basic Scheme libraries

;; Copyright (C) 2016 Marc Nieper-Wißkirchen

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; Copyright (C) Scott G. Miller (2002). All Rights Reserved.

;; Permission is hereby granted, free of charge, to any person obtaining
;; a copy of this software and associated documentation files (the
;; "Software"), to deal in the Software without restriction, including
;; without limitation the rights to use, copy, modify, merge, publish,
;; distribute, sublicense, and/or sell copies of the Software, and to
;; permit persons to whom the Software is furnished to do so, subject to
;; the following conditions:

;; The above copyright notice and this permission notice shall be
;; included in all copies or substantial portions of the Software.

;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
;; OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
;; IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
;; CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
;; TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
;; SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

(define (format format-string . objects)
  (let ((buffer (open-output-string)))
    (let loop ((format-list (string->list format-string))
	       (objects objects))
      (cond
       ((null? format-list) (get-output-string buffer))
       ((char=? (car format-list) #\~)
	(if (null? (cdr format-list))
	    (error "format: incomplete escape sequence" format-string)
	    (case (cadr format-list)
	      ((#\a)
	       (cond
		((null? objects)
		 (error "format: no value for escape sequence ‘~a’" format-string))
		(else
		 (display (car objects) buffer)
		 (loop (cddr format-list) (cdr objects)))))
	      ((#\s)
	       (cond
		((null? objects)
		 (error "format: no value for escape sequence ‘~s’" format-string))
		(else
		 (write (car objects) buffer)
		 (loop (cddr format-list) (cdr objects)))))
	      ((#\%)
	       (newline buffer)
	       (loop (cddr format-list) objects))
	      ((#\~)
	       (write-char #\~ buffer)
	       (loop (cddr format-list) objects))
	      (else
	       (error (format "format: unrecognized escape sequence ‘~~~a’"
			      (cadr format-list)) format-string)))))
       (else
	(write-char (car format-list) buffer)
	(loop (cdr format-list) objects))))))    
