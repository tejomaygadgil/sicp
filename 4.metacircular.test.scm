(print "Testing metacircular evaluator")
(test-global-eval '1 1)
(test-global-eval '(quote x) 'x)
(test-global-eval '(define x 7) 'ok)
(test-global-eval 'x 7)
(test-global-eval '(set! x 8) 'ok)
(test-global-eval 'x 8)
(test-global-eval '(begin 1 (define y 3) y) 3)
(test-global-eval '(define (f x) (+ x x)) 'ok)
(test-global-eval '(f 5) 10)
(test-global-eval '(+ x 1) 9)
(test-global-eval '(if true 1 0) 1)
(test-global-eval '(if (> x y) 'ok 'no) 'ok)
(test-global-eval '(if (< 10 0) x y) 3)
(test-global-eval '(and true true) true)
(test-global-eval '(and true false) false)
(test-global-eval '(or true false) true)
(test-global-eval '(cond (false (/ 1 0)) (true 'hello)) 'hello)
(test-global-eval '(cond (false 'skip) (else 'hello)) 'hello)
(test-global-eval '(let f ((x 10)) (if (= x 1) x (* x (f (- x 1))))) 3628800)
(test-global-eval '(let
                     ((x '(1 2 3 4)))
                     (map (lambda (x) (* x x)) x))
                  '(1 4 9 16))
