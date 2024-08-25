;;;; 1.41
;; Define a procedure `double` that takes a procedure of one argument as argument and returns a procedure that applies the original procedure twice. For example, if `inc` is a procedure that adds 1 to its argument, then `(double inc)` should be a procedure that adds 2. What value is returned by

;; (((double (double double)) inc) 5)

;;; Answer
(define (double f)
  (lambda (x) (f (f x))))

;; Test
(define inc 1+)
(define x (((double (double double)) inc) 5))
(display x)
(newline)

;; `inc` repeats 16 times for 5 + 2^2^2 = 21:
;;       2x        (double (double double))
;;     /    \
;;   2x      2x    ((double double) (double double))
;;  /  \    /  \
;; 2x  2x  2x  2x  (double (double (double (double))))
