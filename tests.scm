(import (scheme base)
	(rapid test)
	(rename (rapid test test) (run-tests run-rapid-test-tests))
	(rename (rapid boxes test) (run-tests run-rapid-boxes-tests)))

(test-begin "Rapid Libraries")

(run-rapid-test-tests)
(run-rapid-boxes-tests)

(test-end "Rapid Libraries")
