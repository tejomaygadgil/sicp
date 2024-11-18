;;;; 3.72
;;  In a similar way to exercise 3.71 generate a stream of all numbers that can be written as the sum of two squares in three different ways (showing how they can be so written).

;; Test
(load "3.70.scm")
(define square-sum
  (let ((weight (lambda (s) (+ (expt (car s) 2) (expt (cadr s) 2)))))
    (let ((square-pairs (weighted-pairs weight integers integers)))
      (stream-filter
        (lambda (x) (apply = (map weight x)))
        (stream-map list
                    square-pairs
                    (stream-cdr square-pairs)
                    (stream-cdr (stream-cdr square-pairs)))))))

;; Test
(display-n square-sum 0 6)
