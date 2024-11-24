;; Test
(load "0.util.scm")
(load "4.metacircular.scm")
(load "4.26.metacircular.unless.scm")
(install-unless)
(eval '(define (factorial n)
         (unless (= n 1) (* n (factorial (- n 1))) 1))
      the-global-environment)
(test (eval '(factorial 5) the-global-environment) 120)
