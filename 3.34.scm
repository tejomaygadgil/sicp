(load "3.constraint.scm")
(load "3.34.multiplier.scm")

(define (squarer a b)
  (multiplier a a b))

;; Test
(load "0.util.scm")
(define x1 (make-connector))
(define x2 (make-connector))
(probe 'x1 x1)
(probe 'x2 x2)
(squarer x1 x2)
(set-value! x2 16 'user)
(newline)
(test (get-value x1) 4)
