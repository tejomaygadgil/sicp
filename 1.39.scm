;;;; 1.38
;; A continued fraction representation of the tangent function was published in 1770 by the German mathematician J.H. Lambert:
;;
;; tan x = x / (1 - x^2 / (3 - x^2 / (5 - ...)))
;;
;; where x is in radians. Define a procedure (tan-cf x k) that computes an approximation to the tangent function based on Lambert's formula. K specifies the number of terms to compute, as in exercise 1.37.

;;; Answer
(load "1.37.scm")
(define (tan-cf x k)
  (cont-frac (lambda (i) (if (> i 1) (- (expt x 2)) x))
             (lambda (i) (- (* i 2) 1))
             k))


(define (display-tan)
  (display (tan-cf 10. 50))
  (newline))

;; Test
(display-tan)
