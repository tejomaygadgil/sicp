;;;; 3.79
;; Generalize the `solve-2nd` procedure of exercise 3.78 so that it can be used to solve general second-order differential equations $d^2 y / d t^2 = f(dy / dt, y)$.

;;; Answer
(load "3.streams.scm")
(load "3.stream.solve.scm")
(define (solve-2nd f dt y0 dy0)
  (define y (integral (delay dy) y0 dt))
  (define dy (integral (delay ddy) dy0 dt))
  (define ddy (stream-map f dy y))
  y)
