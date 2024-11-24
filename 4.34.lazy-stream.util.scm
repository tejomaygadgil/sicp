(load "0.util.scm")
(define (global-eval exp)
  (actual-value exp the-global-environment))
(define (print-global-eval exp)
  (user-print (global-eval exp) the-empty-history) ; Changed
  (newline))
(define (test-global-eval exp val)
  (test (global-eval exp) val))
