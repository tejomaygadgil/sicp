;;;; 1.3
;; Define a procedure that takes three numbers as arguments and returns the sum of the squares of the two larger numbers.

;;; Answer
(load "0.util.scm")
(define (ss-largest-two x y z)
  (define (square x) (* x x))
  (define (sum-of-squares x y) 
    (+ (square x) (square y)))
  (define (larger-two x y z)
    (cond ((and (> y x) (> z x)) (cons y z))
          ((and (> x y) (> z y)) (cons x z))
          (else (cons x y))))
  (define pair (larger-two x y z))
  (sum-of-squares (car pair) (cdr pair)))
  
;; Testing
(test (ss-largest-two 1 2 3) 13)
(test (ss-largest-two 4 2 3) 25)
