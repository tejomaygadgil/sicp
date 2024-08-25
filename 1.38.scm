;;;; 1.38
;; In 1737, the Swiss mathematician Leonhard Euler published a memoir De Fractionibus Continuis, which included a continued fraction expansion for $e - 2$, where $e$ is the base of the natural logarithms. In this fraction, the $N_i$ are all 1, and the $D_i% are successively 1, 2, 1, 1, 4, 1, 1, 6, 1, 1, 8, .... Write a program that uses your `cont-frac` procedure from exercise 1.37 to approximate $e$, based on Euler's expansion.

;;; Answer
(load "1.37.scm")
(define (display-e)
  (display (+ 2
              (cont-frac (lambda (i) 1.0)
                         (lambda (i) (if (= 2 (remainder i 3)) (expt 2 (+ 1 (floor (/ i 3)))) 1))
                         1000)))
  (newline))

;; Test
(display-e)
