;;;; 3.82
;; Redo exercise 3.5 on Monte Carlo integration in terms of streams. The stream version of `estimate-integral` will not have an argument telling how many trials to perform. Instead, it will produce a stream of estimates based on successively more trials.

;;; Answer
(load "3.streams.scm")
(load "3.55.scm")
(define (monte-carlo experiment-stream)
  (let ((average (lambda (passed trials) (/ passed trials)))
        (passed (stream-map (lambda (x) (if x 1. 0.))
                            experiment-stream)))
    (stream-map average
                (partial-sums passed)
                integers)))
(define (estimate-integral P x1 x2 y1 y2)
  (let ((area (* (- x2 x1)
                 (- y2 y1)))
        (point-in-area? (lambda ()
                          (P (random-in-range x1 x2)
                             (random-in-range y1 y2)))))
    (define (make-experiment-stream)
      (cons-stream (point-in-area?)
                   (make-experiment-stream)))
    (scale-stream (monte-carlo (make-experiment-stream))
                  area)))

;; Test
(load "0.util.scm")
(define trials 1e5)
(define delta 1e-2)
(define pi (* 4 (atan 1 1)))
(define pi-estimate
  (estimate-integral 
    (lambda (x y) (<= (+ (square x) (square y)) 1.))
    -1. 1. -1. 1.))
(test (within-delta? (stream-ref pi-estimate trials) pi delta) true)
