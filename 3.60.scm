;;;; 3.60
;; With power series represented as streams of coefficients as in exercise 3.59, adding series is implemented by `add-streams`. Complete the definition of the following procedure for multiplying series:
;;
;; (define (mul-series s1 s2)
;;   (cons-stream <??> (add-streams <??> <??>)))
;;
;; You can test your procedure by verifying that $\sin^2 x + \cos^2 x = 1$, using the series from exercise 3.59.

;;; Answer
(load "3.59.scm")
;; `mul-series` works by providing the $n$th coefficient
;; in the car, and the formula to calculate the $n + 1$th
;; coefficient in the cdr.
;;
;; We can see this by laying our abstraction:
(define (mul-series s1 s2)
  (let ((s1-coeff (stream-car s1))
        (s2-coeff (stream-car s2))
        (s1-rest (lambda () (stream-cdr s1)))
        (s2-rest (lambda () (stream-cdr s2))))
    (let ((the-nth-coeff (* s1-coeff s2-coeff)) ; s1 + s2
          (the-n+1th-coeff
            (lambda ()
              (add-streams (scale-stream (s2-rest) s1-coeff) ; (s2 + 1) + s1
                           (mul-series (s1-rest) s2))))) ; (s1 + 1) + s2
      (cons-stream the-nth-coeff
                   (the-n+1th-coeff)))))

;; Test
(load "0.util.scm")
(define sine-squared-plus-cos-squared
  (add-streams (mul-series sine-series sine-series)
               (mul-series cosine-series cosine-series)))
(map (lambda (x)
       (test (stream-ref sine-squared-plus-cos-squared x)
             (cond ((= x 0) 1)
                   (else 0))))
     (iota 10))
