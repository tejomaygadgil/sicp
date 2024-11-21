;;;; 4.13
;; Scheme allows us to create new bindings for variables by means of `define`, but provides no way to get rid of bindings. Implement for the evaluator a special form `make-unbound!` that removes the binding of a given symbol from the environment in which the `make-unbound!` expression is evaluated. This problem is not completely specified. For example, should we remove only the binding in the first frame of the environment? Complete the specification and justify any choices you make.

;;; Answer
;; We protect enclosing environments by restricting `make-unbound!` to local variables.
(define (make-unbound! var env)
  (let ((result (scan-frame var (first-frame env))))
    (if (null? result)
      (error "Unbound variable -- MAKE-UNBOUND!" var)
      (set-car! (car result) '*unassigned*))))

;; Test
(load "0.util.scm")
(load "4.12.metacircular.frame.scm")
(load "4.12.metacircular.env.scm")
(load "4.12.metacircular.lookup.scm")
(define e1 the-empty-environment)
(define e2 (extend-environment (list 'x 'y) (list 1 2) e1))
(test (lookup-variable-value 'y e2) 2)
(define-variable! 'z 3 e2)
(define-variable! 'y 4 e2)
(test (lookup-variable-value 'z e2) 3)
(test (lookup-variable-value 'y e2) 4)
(define e3 (extend-environment (list 'a 'b) (list 9 8) e2))
(test (lookup-variable-value 'z e3) 3)
(test (lookup-variable-value 'y e3) 4)
(define-variable! 'z 7 e3)
(test (lookup-variable-value 'z e3) 7)
(test e3 '(((z a b) 7 9 8) ((z x y) 3 1 4)))
(make-unbound! 'a e3)
(test e3 '(((z *unassigned* b) 7 9 8) ((z x y) 3 1 4)))
(make-unbound! 'b e3)
(test e3 '(((z *unassigned* *unassigned*) 7 9 8) ((z x y) 3 1 4)))
