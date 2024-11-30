(load "0.util.scm")
(load "2.rule-sub.scm")
(load "2.rule-sub.rules.alg.scm")
(load "2.rule-sub.rules.deriv.scm")
(load "2.rule-sub.rules.scheme.scm")
;; Install
(define algsimp (simplifier algebra-rules))
(define dsimp (simplifier deriv-rules))
(define scheme-evaluator (simplifier scheme-rules))
;; Test
(map print
     (list (scheme-evaluator '(fib 10))
           (dsimp '(dd (+ x y) x))
           (algsimp (dsimp '(dd (+ (* y (+ x y)) x) y))))))
