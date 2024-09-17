;;;; 2.46
;; A two-dimensional vector $v$ running from the origin to a point can be represented as a pair consisting of an x-coordinate and a y-coordinate. Implement a data abstraction for vectors by giving a constructor `make-vect` and corresponding selectors `xcor-vect` and `ycor-vect`. In terms of your selectors and constructor, implement procedures `add-vect`, `sub-vect`, and `scale-vect` that perform the operations vector addition, vector subtraction, and multiplying a vector by a scalar.

;;; Answer
; Cons
(define (make-vect x y) (cons x y))
; Sel
(define (xcor-vect v) (car v))
(define (ycor-vect v) (cdr v))
; Proc
(define (add-vect v1 v2)
  (make-vect (+ (xcor-vect v1) (xcor-vect v2))
             (+ (ycor-vect v1) (ycor-vect v2))))
(define (sub-vect v1 v2)
  (make-vect (- (xcor-vect v1) (xcor-vect v2))
             (- (ycor-vect v1) (ycor-vect v2))))
(define (scale-vect v s)
  (make-vect (* (xcor-vect v) s)
             (* (ycor-vect v) s)))

;; ;; Test
;; (load "0.util.scm")
;; (define a (make-vect 3 4))
;; (define b (make-vect 6 7))
;; (test a (cons 3 4))
;; (test b (cons 6 7))
;; (test (xcor-vect a) 3)
;; (test (ycor-vect a) 4)
;; (test (add-vect a b) (make-vect (+ 3 6) (+ 4 7)))
;; (test (scale-vect a 5) (make-vect (* 3 5) (* 4 5)))
;; (test (add-vect a a) (scale-vect a 2))
;; (test (sub-vect a a) (scale-vect a 0))
