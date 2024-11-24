(load "4.metacircular.test.scm")
(global-eval '(define count 0))
(global-eval '(define (id x)
                (set! count (+ count 1))
                x))
(global-eval '(define (fib n)
                (cond ((= n 0) 0)
                      ((= n 1) 1)
                      (else (+ (fib (- n 1))
                               (fib (- n 2)))))))
(print-global-eval '(fib (id 10)))
(print-global-eval 'count)
