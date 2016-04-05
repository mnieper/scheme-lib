(define-library (rapid lists test)
  (export run-tests)
  (import (scheme base)
	  (rapid test)
	  (rapid lists))
  (begin
    (define (run-tests)
    
      (test-begin "Lists")

      ;; TODO
      
      (test-end)

      #t)))
