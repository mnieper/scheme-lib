(define-library (rapid and-let test)
  (export run-tests)
  (import (scheme base)
	  (rapid test)
	  (rapid and-let))
  (begin
    (define (run-tests)
    
      (test-begin "AND-LET*")

      ;; TODO
      
      (test-end)

      #t)))
