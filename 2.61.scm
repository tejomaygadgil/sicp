;;;; 2.61
;; Give an implementation of `adjoin-set` using the ordered representation. By analogy with `element-of-set?` show how to take advantage of the ordering to produce a procedure that requires on the average about half as many steps as with the unordered representation.

;; Pred
(define (element-of-set? x set)
  (cond ((null? set) false)
        ((= x (car set)) true)
        ((< x (car set)) false)
        (else (element-of-set? x (cdr set)))))
;; Proc
(define (intersection-set set1 set2)
  (if (or (null? set1) (null? set2))
    '()
    (let ((x1 (car set1)) (x2 (car set2)))
      (cond ((= x1 x2)
             (cons x1
                   (intersection-set (cdr set1)
                                     (cdr set2))))
            ((< x1 x2)
             (intersection-set (cdr set1) set2))
            ((< x2 x1)
             (intersection-set set1 (cdr set2)))))))

;;; Answer
(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((= x (car set)) set)
        ((< x (car set)) (cons x set))
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))

;; ;; Test
;; (load "0.util.scm")
;; (define s1 (list 1 2 4 5))
;; (test (adjoin-set 3 s1) (list 1 2 3 4 5))
;; (test (adjoin-set 6 s1) (list 1 2 4 5 6))

;; `adjoin-set` does not have to iterate through the entire list to determine membership. We know we are done when `x` finds an element bigger than it, and can stop iterating right there. On the other hand, the vanilla method has to iterate the entire set because `x` could be anywhere.
