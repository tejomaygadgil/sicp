(load "3.streams.scm")

(define (integral integrand initial-value dt)
  (define int
    (cons-stream initial-value
                 (add-streams (scale-stream integrand dt)
                              int)))
  int)

(define (f-dt f dt)
  (stream-map f
              (scale-stream (integers-starting-from 0)
                            dt)))

(define x 3)
(define n 100000.)
(define dt (/ 1 n))
(define (sq x) (* x x))
(define sq-x (f-dt sq dt))
(define int-sq-x (integral s-sq-x 0 dt))
(display
  (stream-ref
    (stream-map list
                sq-x
                (stream-cdr int-sq-x))
    (+ (* x n) 1)))
