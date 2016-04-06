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

(define-record-type map-type
  (%make-map comparator entries)
  map?
  (comparator map-comparator)
  (entries map-entries map-set-entries!))

(define (map-equality-predicate map)
  (comparator-equality-predicate (map-comparator map)))

(define (make-map comparator)
  (%make-map comparator '()))

(define map-ref
  (case-lambda
   ((map key)
    (map-ref map key (lambda () (error "key not found" key))))
   ((map key failure)
    (cond
     ((assoc key (map-entries map) (map-equality-predicate map)) => cdr)
     (else (failure))))))

(define (map-ref/default map key default)
  (map-ref map key (lambda () default)))

(define (map-set map key value)
  (%make-map (map-comparator map)
	     (cons (cons key value)
		   (map-entries map))))

(define (map-delete map key)
  (define equality (map-equality-predicate map))
  (%make-map
   (map-comparator map)
   (let loop ((entries (map-entries map)))
     (cond
      ((null? entries)
       '())
      ((equality (caar entries) key)
       (cdr entries))
      (else
       (cons (car entries)
	     (loop (cdr entries))))))))

;; TODO: exchange the order of arguments
;; TODO: allow more than one seed and use values
(define (map-fold map proc seed)
  (let loop ((entries (map-entries map)))
    (if (null? entries)
	seed
	(proc (caar entries) (cdar entries) (loop (cdr entries))))))

(define (map-for-each proc map)
  (for-each
   (lambda (entry)
     (proc (car entry) (cdr entry)))
   (map-entries map)))
