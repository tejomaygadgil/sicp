;; 2.7.scm make-interval, upper-bound, lower-bound
;; 2.8.scm sub-interval
;; 2.10.scm Error handling div-interval
;; 2.12.scm center-width, center-percent
(load "2.12.scm")

(define (display-interval interval)
  (display "center: ") (display-round (center interval) 3) (display ", ")
  (display "percent: ") (display-round (percent interval) 3) (newline)
  (newline))

(define (display-round x n)
  (let ((factor (expt 10 n)))
    (display (/ (round (* x factor)) factor))))
