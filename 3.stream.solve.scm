(define (integral delayed-integrand initial-value dt)
  (define int
    (cons-stream initial-value
                 (let ((integrand (force delayed-integrand)))
                   (add-streams (scale-stream integrand dt)
                                int))))
  int)
(define (solve f y0 dt)
  (define y (integral (delay dy) y0 dt))
  (define dy (stream-map f y))
  y)
(define (display-solve f y0 t steps)
  (display (stream-ref (solve f y0 (/ 1. steps)) (* t steps)))
  (newline))

;; ;; Test
;; (load "0.util.scm")
;; (load "3.streams.scm")
;; (display-solve (lambda (y) y) 1 1 1000)
