(import (scheme base)
	(rapid test)
	(rename (rapid test test) (run-tests run-rapid-test-tests))
	(rename (rapid box test) (run-tests run-rapid-box-tests)))

(test-begin "Rapid Libraries")

(run-rapid-test-tests)
(run-rapid-box-tests)

(test-end "Rapid Libraries")
