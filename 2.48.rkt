;;;; 2.48
;; A directed line segment in the plane can be represented as a pair of vectors -- the vector running from the origin to the start-point of the segment, and the vector running from the origin to the end-point of the segment. Use your vector representation from exercise 2.46 to define a representation for segments with a constructor `make-segment` and selectors `start-segment` and `end-segment`.

;;; Answer
(load "2.47.rkt")
(define (make-segment v1 v2) (cons v1 v2))
(define (start-segment s) (car s))
(define (end-segment s) (cdr s))

;; ;; Test
;; (load "0.util.scm")
;; (define v1 (make-vect 2 3))
;; (define v2 (make-vect 4 5))
;; (define s1 (make-segment v1 v2))
;; (test s1 (cons v1 v2))
;; (test (start-segment s1) (car s1))
;; (test (end-segment s1) (cdr s1))
