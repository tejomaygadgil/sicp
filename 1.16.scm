;;;; 1.16
;; Design a procedure that evolves an iterative exponentiation process that uses successive squaring and uses a logarithmic number of steps, as does `fast-expt`.
;; (Hint: Using the observation that $(b^{n/2})^2 = (b^2)^{n/2}$, keep, along with the exponent $n$ and the base $b$, an additional state variable $a$, and define the state transformation in such a way that the product $a b^n$ is unchanged from state to state. At the beginning of the process $a$ is taken to be 1, and the answer is given by the value of $a$ at the end of the process. In general, the technique of defining an *invariant quantity* that remains unchanged from state to state is a powerful way to think about the design of iterative algorithms.)

;;; Answer
(define (fast-expt b n)
  (define (even? x) (= (remainder x 2) 0))
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))

(define (iter-expt b n)
  (define (even? x) (= (remainder x 2) 0))
  (define (iter b n p)
    (cond ((= n 0) p)
          ((even? n) (iter (square b) (/ n 2) p))
          (else (iter b (- n 1) (* p b)))))
  (iter b n 1))


;; Test
(load "0.util.scm")
(test (fast-expt 3 4) (iter-expt 3 4))
