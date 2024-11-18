;;;; 3.65
;; Use the series
;;
;; $$ \ln 2 = 1 - \frac{1}{2} + \frac{1}{3} - \frac{1}{4}$$
;;
;; to compute three sequences of approximations to the natural logarithm of 2, in the same way we did above for $\pi$. How rapidly do these sequences converge?

(define (euler-transform s)
  (let ((s0 (stream-ref s 0))           ; Sn-1
        (s1 (stream-ref s 1))           ; Sn
        (s2 (stream-ref s 2)))          ; Sn+1
    (cons-stream (- s2 (/ (square (- s2 s1))
                          (+ s0 (* -2 s1) s2)))
                 (euler-transform (stream-cdr s)))))
(define (make-tableau transform s)
  (cons-stream s
               (make-tableau transform
                             (transform s))))
(define (accelerated-sequence transform s)
  (stream-map stream-car
              (make-tableau transform s)))

;;; Answer
(load "3.streams.scm")
(load "3.55.scm") ; partial-sums
(load "3.64.scm") ; stream-limit
(define ln-stream
  (partial-sums (div-streams alternating-ones
                             (scale-stream integers
                                           1.))))
(define euler-ln-stream
  (euler-transform ln-stream))
(define accelerated-ln-stream
  (accelerated-sequence euler-transform
                        ln-stream))
(map (lambda (x)
       (let ((tolerance 1e-5))
         (stream-limit x tolerance)))
     (list ln-stream
           euler-ln-stream
           accelerated-ln-stream))
;; 99998 steps to converge to .6931421805849816
;; 27 steps to converge to .6931515803143488
;; 3 steps to converge to .6931471960735491
