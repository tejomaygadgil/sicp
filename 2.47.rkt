;;;; 2.47
;; Here are two possible constructors for frames:
;;
;; (define (make-frame origin edge1 edge2)
;;   (list origin edge1 edge2))
;;
;; (define (make-frame origin edge1 edge2)
;;   (cons origin (cons edge1 edge2)))
;;
;; For each constructor supply the appropriate selectors to produce an implementation for frames.

;;; Answer
(load "2.46.rkt")
(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))
(define (origin-frame f) (list-ref f 0))
(define (edge1-frame f) (list-ref f 1))
(define (edge2-frame f) (list-ref f 2))

;; ;; Test
;; (load "0.util.scm")
;; (define v0 (make-vect 0 1))
;; (define v1 (make-vect 2 3))
;; (define v2 (make-vect 4 5))
;; (define f1 (make-frame v0 v1 v2))
;; (test (origin-frame f1) v0)
;; (test (edge1-frame f1) v1)
;; (test (edge2-frame f1) v2)

(define (make-frame origin edge1 edge2)
  (cons origin (cons edge1 edge2)))
(define (origin-frame f) (car f))
(define (edge1-frame f) (cadr f))
(define (edge2-frame f) (caddr f))

;; ;; Test
;; (test (origin-frame f1) v0)
;; (test (edge1-frame f1) v1)
;; (test (edge2-frame f1) v2)
