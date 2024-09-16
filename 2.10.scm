;;;; 2.10
;; Ben Bitdiddle, an expert systems programmer, looks over Alyssa's shoulder and comments that it is not clear what it means to divide by an interval that spans zero. Modify Alyssa's code to check for this condition and to signal an error if it occurs.

;;; Answer
(load "2.8.scm")
(define (div-interval x y)
  (if (< (* (lower-bound y) (upper-bound y)) 0)
    (error "Division error (interval spans 0)" y) ; Throw error
    (mul-interval x
                  (make-interval (/ 1.0 (lower-bound y))
                                 (/ 1.0 (upper-bound y))))))
