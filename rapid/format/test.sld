(define-library (rapid format test)
  (import (scheme base)
          (scheme write)
          (rapid test)
          (rapid format))
  (export run-tests)
  (begin
    (define (run-tests)
      (test-begin "Format")

      (test-assert "Values can be inserted as if printed with display"
   	           (let ((p (open-output-string)))
	             (display "42" p)
	           (string=? (format "~a" "42") (get-output-string p))))

      (test-assert "Values can be inserted as if printed with write"
        	   (let ((p (open-output-string)))
	             (write "43" p)
	           (string=? (format "~s" "43") (get-output-string p))))

      (test-equal "Newline escape sequence"
                  "\n"
  	          (format "~%"))

      (test-equal "Tilde escape sequence"
                  "~"  	          
                  (format "~~"))

      (test-end)

      #t)))
