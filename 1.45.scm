;;;; 1.45
;; We saw in section 1.3.3 that attempting to compute square roots by naively finding a fixed point of $y \rightarrow x/y$ does not converge, and that this can be fixed by average damping. The same method works for finding cube roots as fixed points of the average-damped $y \rightarrow x/y^2$. Unfortunately, the process does not work for fourth roots -- a single average damp is not enough to make a fixed-point search for $y \rightarrow x/y^3$ converge. On the other hand, if we average damp twice (i.e., use the average damp of the average damp of $y \rightarrow x/y^3$) the fixed-point search does converge. Do some experiments to determine how many average damps are required to compute nth roots as a fixed-point search based upon repeated average damping of $y \rightarrow x/y^{n-1}$. Use this to implement a simple procedure for computing $n$th roots using `fixed-point`, `average-damp`, and the `repeated` procedure of exercise 1.43. Assume that any arithmetic operations you need are available as primitives.

;;; Answer
(load "1.fixed-point.scm")
(load "1.43.scm")

(define (average-damp f)
  (define (average x y) (/ (+ x y) 2))
  (lambda (x) (average x (f x))))
(define (n-root x n r)
  (fixed-point
    (repeated (average-damp (lambda (y) (/ x (expt y (- n 1)))))
              r)
    1.0))

;; Test
(define x 2)
(define n 6)
(define r 5)
(display (n-root x n r))
(newline)

;; Increasing smoothing to absurd values (1e4) helps in some cases (n=3).
