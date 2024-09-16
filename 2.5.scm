;;;; 2.5
;; Show that we can represent pairs of nonnegative integers using only numbers and arithmetic operations if we represent the pair `a` and `b` as the integer that is the product $2^a 3^b$. Give the corresponding definitions of the procedures `cons`, `car`, and `cdr`.

;;; Answer
(define (get-exponent z n)
  (if (not (= (remainder z n) 0)) 0
    (+ 1 (get-exponent (/ z n) n))))
(define (cons x y)
  (* (expt 2 x) (expt 3 y)))
(define (car z)
  (get-exponent z 2))
(define (cdr z)
  (get-exponent z 3))

;; Test
(load "0.util.scm")
(define point (cons 5 4))
(test (car point) 5)
(test (cdr point) 4)
