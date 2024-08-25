;;;; 1.44
;; The idea of *smoothing* a function is an important concept in signal processing. If $f$ is a function and $dx$ is some small number, then the smoothed version of $f$ is the function whose value at a point $x$ is the average of $f(x - dx)$, $f(x)$, and $f(x + dx)$. Write a procedure `smooth` that takes as input a procedure that computes $f$ and returns a procedure that computes the smoothed $f$. It is sometimes valuable to repeatedly smooth a function (that is, smooth the smoothed function, and so on) to obtained the *n-fold smoothed function*. Show how to generate the n-fold smoothed function of any given function using `smooth` and `repeated` from exercise 1.43.

;;; Answer
(load "1.43.scm")
(define dx 0.00001)
(define (smooth f)
  (lambda (x)
    (/ (+ (f (- x dx)) (f x) (f (+ x dx)))
       3)))

(define (n-smooth f n)
  ((repeated smooth n) f))

;; Test
(define fold-values '(1 2 3 4 5 6 7 8 9 10))
(define (display-fold n)
  (define (step x) (cond ((< x 0) 0.) (else 1.)))
  (display "n=")
  (display n)
  (display "\t f(0)=")
  (display ((n-smooth step n) 0))
  (newline))
(display "Smoothing `step` with dx=")
(display dx)
(newline)
(map display-fold
     fold-values)
