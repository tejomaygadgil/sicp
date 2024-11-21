;;;; 4.12
;; The procedures `set-variable-value!`, `define-variable!`, and `lookup-variable-value` can be expressed in terms of more abstract procedures for traversing the environment structure. Define abstractions that capture the common patterns and redefine the three procedures in terms of these abstractions.

;; Test
(load "0.util.scm")
(load "4.12.metacircular.frame.scm")
(load "4.12.metacircular.env.scm")
(load "4.12.metacircular.lookup.scm")
(define e1 the-empty-environment)
(define e2 (extend-environment (list 'x 'y) (list 1 2) e1))
(test (lookup-variable-value 'x e2) 1)
(test (lookup-variable-value 'y e2) 2)
(set-variable-value! 'y 4 e2)
(test (lookup-variable-value 'y e2) 4)
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
