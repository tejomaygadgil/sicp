;;;; 3.33
;; Using primitive multiplier, adder, and constant constraints, define a procedure `averager` that takes three connectors `a`, `b`, and `c` as inputs and establishes the constraint that the value of `c` is the average of the values of `a` and `b`.

;;; Answer
(load "3.constraint.scm")
(define (averager x1 x2 avg)
  (let ((sum (make-connector))
        (two (make-connector)))
    (constant 2 two)
    (adder x1 x2 sum)
    (multiplier two avg sum)
    'ok))

;; Test
(load "0.util.scm")
(define x1 (make-connector))
(define x2 (make-connector))
(define avg (make-connector))
(probe 'x1 x1)
(probe 'x2 x2)
(probe 'avg avg)
(averager x1 x2 avg)
(set-value! x1 4 'user)
(set-value! x2 2 'user)
(newline)
(test (get-value avg) 3)
(forget-value! x2 'user)
(set-value! avg 7 'user)
(newline)
(test (get-value x2) 10)
