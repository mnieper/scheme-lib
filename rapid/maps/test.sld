(define-library (rapid maps test)
  (export run-tests)
  (import (scheme base)
	  (rapid test)
          (rapid comparators)
	  (rapid maps))
  (begin
    (define (run-tests)
    
      (test-begin "Maps")

      (test-assert "Allocating a map yields a map"
                   (map? (make-map (make-equal-comparator))))

      (test-equal "Stored values can be retrieved"
                  2
                  (map-ref (map-set (make-map (make-eqv-comparator)) 1 2) 1))

      (test-equal "Default values are returned if no value inserted"
                  6
                  (map-ref/default (map-set (make-map (make-eqv-comparator)) 3 4) 5 6))


      (test-equal "Stored values can be overwritten"
                  9
                  (map-ref (map-set
                            (map-set
                             (make-map (make-eqv-comparator))
                             7 8)
                            7 9)
                           7))

      (test-end)

      #t)))
