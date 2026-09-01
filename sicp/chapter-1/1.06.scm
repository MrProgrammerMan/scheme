;; When Alyssa attempts to run the code it hangs on infinite recursion.
;; The false-branch of the if-test is evaluated before the if. This itself repeats the self-call.
;; This means the function never terminates since the if never gets to evaluate.