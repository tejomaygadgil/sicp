;;;; 2.12
;; Define a constructor `make-center-percent` that takes a center and a percentage tolerance and produces the desired interval. You must also define a selector `percent` that produces the percentage tolerance for a given interval. The `center` selector is the same as the one shown above.

(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))
(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))
(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

;;; Answer
(load "2.10.scm")
(define (make-center-percent center percent)
  (let ((width (/ (* center (/ percent 100)) 2)))
    (make-center-width center width)))
(define (percent interval)
  (* (/ (* (width interval) 2) (center interval)) 100))

;; ;; Test
;; (define x (make-center-percent 10 3.))
;; (display x)
;; (newline)
;; (display (center x))
;; (newline)
;; (display (width x))
;; (newline)
;; (display (percent x))
;; (newline)
