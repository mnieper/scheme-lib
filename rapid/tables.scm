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

(define-record-type table-type
  (%make-table comparator entries)
  table?
  (comparator table-comparator)
  (entries table-entries table-set-entries!))

(define (make-table comparator) (%make-table comparator '()))

(define (table-equality-predicate table)
  (comparator-equality-predicate (table-comparator table)))

(define table-ref
  (case-lambda
   ((table key)
    (table-ref table key (lambda () (error "table-ref: not contained in hash table"
					   key))))
   ((table key thunk)
    (define equality (table-equality-predicate table))
    (cond
     ((assoc key (table-entries table) equality) => cdr)
     (else (thunk))))))

(define (table-ref/default table key default)
  (table-ref table key (lambda () default)))
  
(define (table-set! table key value)
  (define equality (table-equality-predicate table))
  (define entries (table-entries table))
  (cond
   ((assoc key entries equality)
    => (lambda (entry)
	 (set-cdr! entry value)))
   (else
    (table-set-entries! table (cons (cons key value) entries)))))

(define (table-update! table key updater failure success)
  (define equality (table-equality-predicate table))
  (define entries (table-entries table))
  (cond
   ((assoc key entries equality)
    => (lambda (entry)
	 (set-cdr! entry (updater (success (cdr entry))))))
   (else
    (table-set-entries! table (cons (cons key (updater (failure))) entries)))))

(define (table-intern! table key failure)
  (define equality (table-equality-predicate table))
  (define entries (table-entries table))
  (cond
   ((assoc key entries equality) => cdr)
   (else
    (let ((value (failure)))
      (table-set-entries! table (cons (cons key value) entries))
      value))))

(define (table-for-each proc table)
  (map
   (lambda (entry)
     (proc (car entry) (cdr entry)))
   (table-entries table)))

(define (table-keys table)
  (map car (table-entries table)))
     
