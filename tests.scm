(import (scheme base)
	(rapid test)
	(rename (rapid test test) (run-tests run-rapid-test-tests))
	(rename (rapid boxes test) (run-tests run-rapid-boxes-tests))
        (rename (rapid comparators test) (run-tests run-rapid-comparators-tests))
	(rename (rapid lists test) (run-tests run-rapid-lists-tests))
        (rename (rapid tables test) (run-tests run-rapid-tables-tests))
	(rename (rapid generators test) (run-tests run-rapid-generators-tests)))

(test-begin "Rapid Libraries")

(run-rapid-test-tests)
(run-rapid-boxes-tests)
(run-rapid-generators-tests)
(run-rapid-lists-tests)
(run-rapid-tables-tests)
(run-rapid-generators-tests)

(test-end "Rapid Libraries")
