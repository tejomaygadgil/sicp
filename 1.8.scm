;;;; 1.8
;; Newton's method for cube roots is based on the fact that if y is an approximation to the cube root of x, then a better approximation is given by the value:
;;
;; ((x / y^3) + 2 * y) / 3
;;
;; Use this formula to implement a cube-root procedure analogous to the square-root procedure. (In section 1.3.4 we will see how to implement Newton's method in general as an abstraction of these square-root and cube-root procedures.)

;;; Answer
(load "1.7.scm")
(define (improve guess x)
  (/ (+ (/ x (* guess guess)) (* 2 guess)) 3))
(define (cube-iter guess old_guess x)
  (if (good-enough? guess old_guess)
      guess 
      (cube-iter (improve guess x) guess x)))
(define (cube-root x)
  (cube-iter 1.0 2.0 x))

;; Test
(display (cube-root 10))
