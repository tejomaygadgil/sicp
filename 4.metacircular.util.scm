(load "0.util.scm")
(define (global-eval exp)
  (eval exp the-global-environment))
(define (print-global-eval exp)
  (print (global-eval exp)))
(define (test-global-eval exp val)
  (test (global-eval exp) val))