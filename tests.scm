(import (scheme base)
	(rapid test)
	(rename (rapid test test) (run-tests run-rapid-test-tests))
	(rename (rapid boxes test) (run-tests run-rapid-boxes-tests))
	(rename (rapid generators test) (run-tests run-rapid-generators-tests)))

(test-begin "Rapid Libraries")

(run-rapid-test-tests)
(run-rapid-boxes-tests)
(run-rapid-generators-tests)

(test-end "Rapid Libraries")
