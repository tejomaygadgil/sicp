;;;; 3.77
;;  The integral procedure used above was analogous to the "implicit~ definition of the infinite stream of integers in section 3.5.2. Alternatively, we can give a definition of `integral` that is more like `integers-starting-from` (also in section 3.5.2):
;;
;; (define (integral integrand initial-value dt)
;;   (cons-stream initial-value
;;                (if (stream-null? integrand)
;;                    the-empty-stream
;;                    (integral (stream-cdr integrand)
;;                              (+ (* dt (stream-car integrand))
;;                                 initial-value)
;;                              dt))))
;;
;; When used in systems with loops, this procedure has the same problem as does our original version of `integral`. Modify the procedure so that it expects the `integrand` as a delayed argument and hence can be used in the `solve` procedure shown above.

;; Answer
(load "3.streams.scm")
(load "3.stream.solve.scm")
;; Integration is repeated, scaled addition to
;; an initial constant value. Rather than referring
;; to itself as data, this `integral` constructs
;; a new procedure to represent the next accumulation.
(define (integral delayed-integrand initial-value dt) ; Shadows
  (cons-stream initial-value
               (let ((integrand (force delayed-integrand))) ; Changed
                 (if (stream-null? integrand)
                     the-empty-stream
                     (integral (delay (stream-cdr integrand)) ; Changed
                               (+ (* dt (stream-car integrand))
                                  initial-value)
                               dt)))))

;; Test
(load "0.util.scm")
(print (stream-ref (solve (lambda (y) y) 1 0.001) 1000))
