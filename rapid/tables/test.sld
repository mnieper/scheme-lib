(define-library (rapid tables test)
  (export run-tests)
  (import (scheme base)
	  (rapid test)
          (rapid comparators)
	  (rapid tables))
  (begin
    (define (run-tests)
    
      (test-begin "Tables")

      (test-assert "Allocating a table yields a table"
	     (table? (make-table (make-eqv-comparator))))

      (test-equal "Stored values can be retrieved"
		  '(a b)
		  (let ((table (make-table (make-eqv-comparator))))
		    (table-set! table 1 'a)
		    (table-set! table 2 'b)
		    (list (table-ref table 1) (table-ref table 2))))
      
      (test-error "Non-existing values cannot be retrieved"
		  #t
		  (let ((table (make-table (make-eqv-comparator))))
		    (table-set! table 3 'c)
		    (table-ref table 4)))
      
      (test-eqv "Defaults are provided when key cannot be found"
		42
		(let ((table (make-table (make-eqv-comparator))))
		  (table-set! table 5 'f)
		  (table-ref table 6 (lambda () 42))))
      
      (test-equal "Values can be overwritten"
		  '(gg h)
		  (let ((table (make-table (make-eqv-comparator))))
		    (table-set! table 7 'g)
		    (table-set! table 8 'h)
		    (table-set! table 7 'gg)
		    (list (table-ref table 7) (table-ref table 8))))
      
      (test-equal "Values can be interned"
		  '(j i j)
		  (let ((table (make-table (make-eqv-comparator))))
		    (table-set! table 9 'i)
		    (let* ((x (table-intern! table 10 (lambda () 'j)))
			   (y (table-intern! table 9 (lambda () 'ii)))
			   (z (table-ref table 10)))
		      (list x y z))))
      
      ;; TODO: table-ref/default

      (test-end "Tables")

      #t)))
