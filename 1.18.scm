;;;; 1.18
;; Using the results of exercises 1.16 and 1.17, devise a procedure that generates an iterative process for multiplying two integers in terms of adding, doubling, and halving and uses a logarithmic number of steps.

;;; Answer
(define (iter-mult a b)
  (define (double x) (+ x x))
  (define (halve x) (/ x 2))
  (define (iter a b o)
    (cond ((= b 0) o)
          ((even? b) (iter (double a) (halve b) o))
          (else (iter a (- b 1) (+ o a)))))
  (iter a b 0))

;; Test
(load "0.util.scm")
(test (iter-mult 5 17) (* 5 17))
