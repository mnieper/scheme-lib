(define-library (rapid generators test)
  (export run-tests)
  (import (scheme base)
	  (rapid test)
	  (rapid generators))
  (begin
    (define (run-tests)

      (test-begin "Generators")

      (test-begin "make-coroutine-generator")

      (test-equal "Coroutine generators"
		  '(2 1 0)
		  (let ((g (make-coroutine-generator
			    (lambda (yield)
			      (let loop ((i 0))
				(when (< i 3) (yield i)
				  (loop (+ i 1))))))))
		    (generator-fold cons '() g)))
      
      (test-end "make-coroutine-generator")

      (test-begin "make-range-generator")
      
      (test-equal "Range generators"
		  '(7 5 3)
		  (generator-fold cons '() (make-range-generator 3 8 2)))

      (test-end "make-range-generator")

      (test-begin "gappend")
      
      (test-equal "Append generators"
		  '(1 0 2 1 0)
		  (generator-fold cons '() (gappend (make-range-generator 0 3)
						    (make-range-generator 0 2))))
      
      (test-end "gappend")
      
      (test-end "Generators")

      #t)))
