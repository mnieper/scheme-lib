(define-library (rapid sets test)
  (export run-tests)
  (import (scheme base)
	  (rapid test)
	  (rapid lists))
  (begin
    (define (run-tests)
    
      (test-begin "Sets")

      ;; TODO
      
      (test-end)

      #t)))
