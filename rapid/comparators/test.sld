(define-library (rapid comparators test)
  (export run-tests)
  (import (scheme base)
	  (rapid test)
	  (rapid comparators))
  (begin
    (define (run-tests)
    
      (test-begin "Comparators")

      ;; TODO
      
      (test-end "Comparators")

      #t)))
