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

(define-record-type <set>
  (%make-set comparator elements)
  set?
  (comparator set-comparator)
  (elements set-elements set-set-elements!))

(define (make-set comparator)
  (%make-set comparator '()))

(define (set-equality-predicate set)
  (comparator-equality-predicate (set-comparator set)))

(define (set-contains? set element)
  (define equality (set-equality-predicate set))
  (let loop ((elements (set-elements set)))
    (and (not (null? elements))
	 (or (equality (car elements) element)
	     (loop (cdr elements))))))

(define (set-adjoin set element)
  (%make-set
   (set-comparator set)
   (cons element (set-elements set))))
