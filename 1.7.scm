;;;; 1.7
;; The `good-enough?` test used in computing square roots will not be very effective for finding the square roots of very small numbers. Also, in real computers, arithmetic operations are almost always performed with limited precision. This makes our test inadequate for very large numbers. Explain these statements, with examples showing how the test fails for small and large numbers. An alternative strategy for implementing `good-enough?` is to watch how guess changes from one iteration to the next and to stop when the change is a very small fraction of the guess. Design a square-root procedure that uses this kind of end test. Does this work better for small and large numbers?

;;; Answer
(define (improve guess x)
  (/ (+ guess (/ x guess)) 2))

(define (good-enough? guess old_guess)
  (define threshold 0.001)
  (define abs-% (abs (/ (- guess old_guess) old_guess)))
  (< abs-% threshold))

(define (sqrt-iter guess old_guess x)
  (if (good-enough? guess old_guess)
          guess 
          (sqrt-iter (improve guess x) 
                     guess 
                     x)))

(define (square-root x)
  (sqrt-iter 1.0 2.0 x))

;; ;; Switching to percent difference improves the stopping criteria for larger numbers and produces more accurate estimates for smaller numbers.
;; (define x 2938402948209580)
;; (display (square-root x))
