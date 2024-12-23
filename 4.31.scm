;;;; 4.31
;; The approach taken in this section is somewhat unpleasant, because it makes an incompatible change to Scheme. It might be nicer to implement lazy evaluation as an *upward-compatible extension*, that is, so that ordinary Scheme programs will work as before. We can do this by extending the syntax of procedure declarations to let the user control whether or not arguments are to be delayed. While we're at it, we may as well also give the user the choice between delaying with and without memoization. For example, the definition
;;
;; (define (f a (b lazy) c (d lazy-memo))
;;   ...)
;;
;; would define `f` to be a procedure of four arguments, where the first and third arguments are evaluated when the procedure is called, the second argument is delayed, and the fourth argument is both delayed and memoized. Thus, ordinary procedure definitions will produce the same behavior as ordinary Scheme, while adding the `lazy-memo` declaration to each parameter of every compound procedure will produce the behavior of the lazy evaluator defined in this section. Design and implement the changes required to produce such an extension to Scheme. You will have to implement new syntax procedures to handle the new syntax for `define`. You must also arrange for `eval` or `apply` to determine when arguments are to be delayed, and to force or delay arguments accordingly, and you must arrange for forcing to memoize or not, as appropriate.

(load "4.lazy.scm")
(load "4.31.lazy-upward.parameter.scm")
(load "4.31.lazy-upward.thunk.scm")
(load "4.31.lazy-upward.apply.scm")

;; Test
(load "4.metacircular.test.scm")
(print "Testing lazy-upward evaluator")
;; Lazy
(global-eval '(define acc '()))
(global-eval '(define (f (x lazy) y)
                      (set! acc (cons 'f acc))
                      (+ x y)))
(test-global-eval '(f (begin (set! acc (cons 'x acc)) 10)
                      (begin (set! acc (cons 'y acc)) 11))
                  21)
(test-global-eval 'acc '(x f y))
;; Lazy-memo
(global-eval '(define acc '()))
(global-eval '(define (g (x lazy) (y lazy-memo))
                      (+ x y)
                      (+ x y)
                      (+ x y)))
(test-global-eval '(g (begin (set! acc (cons 'x acc)) 10)
                      (begin (set! acc (cons 'y acc)) 11))
                  21)
(test-global-eval 'acc '(x x y x))

;; Run
(driver-loop)
