;;;; 2.8
;; Using reasoning analogous to Alyssa's, describe how the difference of two intervals may be computed. Define a corresponding subtraction procedure, called `sub-interval`.

;;; Answer
(load "2.7.scm")
(define (sub-interval x y)
  (add-interval x
                (make-interval (* -1 (upper-bound y))
                               (* -1 (lower-bound y)))))

;; ;; Test
;; (display (sub-interval (cons 7 10) (cons 1 2)))
;; (newline)
