;;;; 3.1
;; An *accumulator* is a procedure that is called repeatedly with a single numeric argument and accumulates its arguments into a sum. Each time it is called, it returns the currently accumulated sum. Write a procedure `make-accumulator` that generates accumulators, each maintaining an independent sum. The input to `make-accumulator` should specify the initial value of the sum; for example
;;
;; (define A (make-accumulator 5))
;; (A 10)
;; 15
;; (A 10)
;; 25

;;; Answer
(define (make-accumulator initial-value)
  (lambda (addend)
    (set! initial-value (+ initial-value addend))
    initial-value)))

;; Test
(load "0.util.scm")
(define A (make-accumulator 5))
(test (A 10) 15)
(define B (make-accumulator 7))
(test (B 10) 17)
(test (A 10) 25)
(test (B 10) 27)
