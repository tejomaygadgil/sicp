;;;; 3.62
;; Use the results of exercises 3.60 and 3.61 to define a procedure `div-series` that divides two power series. `Div-series` should work for any two series, provided that the denominator series begins with a nonzero constant term. (If the denominator has a zero constant term, then `div-series` should signal an error.) Show how to use `div-series` together with the result of exercise 3.59 to generate the power series for tangent.

;;; Answer
(load "3.61.scm")
(define (invert-series series) ; Account for non-unit series
  (let ((factor (/ 1 (stream-car series))))
    (scale-stream (invert-unit-series (scale-stream series
                                                    factor))
                  factor)))
(define (div-series s1 s2)
  (if (zero? (stream-car s2))
      (error "Division by zero -- DIV-SERIES" s1 s2)
      (mul-series s1
                  (invert-series s2))))
(define tangent-series (div-series sine-series cosine-series))

;; Test
(display-n tangent-series 0 10)
