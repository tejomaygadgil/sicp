;;;; 2.59
;; Implement the `union-set` operation for the unordered-list representation of sets.

;; Pred
(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))
;; Proc
(define (adjoin-set x set)
  (if (element-of-set? x set)
    set
    (cons x set)))
(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
         (cons (car set1)
               (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))

;;; Answer
(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        ((element-of-set? (car set1) set2)
         (union-set (cdr set1) set2))
        (else (cons (car set1)
               (union-set (cdr set1) set2)))))

;; ;; Test
;; (load "0.util.scm")
;; (define S (list 0 1 2 3))
;; (define T (list 2 3 4 5))
;; (define U (list 6 7 8 9))
;; (test (union-set S T) (list 0 1 2 3 4 5))
;; (test (union-set S U) (list 0 1 2 3 6 7 8 9))
;; (test (union-set (list 1) (list 2)) (list 1 2))
;; (test (union-set S S) S)
;; (test (union-set S ()) S)
;; (test (union-set () S) (list 0 1 2 3))
