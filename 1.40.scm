;;;; 1.40
;; Define a procedure `cubic` that can be used together with the `newtons-method` procedure in expressions of the form
;;
;; (newtons-method (cubic a b c) 1)
;;
;; to approximate zeros of the cubic $x^3 + ax^2 + bx + c$.

;;; Answer
(load "1.newtons-method.scm")
(define (cubic a b c)
  (lambda (x) (+ (expt x 3)
                 (* a (expt x 2))
                 (* b x)
                 c)))

;; Test
(define a 11)
(define b 7)
(define c 6)
(define g (cubic a b c))
(define root (newtons-method g 1))
(display "a \t") (display a)
(newline)
(display "b \t") (display b)
(newline)
(display "c \t") (display c)
(newline)
(display "x \t") (display root)
(newline)
(display "g(x) \t") (display (g root))
(newline)
