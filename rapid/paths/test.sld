(define-library (rapid paths test)
  (export run-tests)
  (import (scheme base)
	  (rapid test)
	  (rapid paths))
  (begin
    (define (run-tests)
    
      (test-begin "Paths")

      ;; TODO
      
      (test-end)

      #t)))
