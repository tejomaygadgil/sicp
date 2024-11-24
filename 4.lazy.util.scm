(load "0.util.scm")
(define (global-eval exp)
  (actual-value exp the-global-environment)) ; Changed
(define (print-global-eval exp)
  (user-print (global-eval exp))) ; Changed
(define (test-global-eval exp val)
  (test (global-eval exp) val))
