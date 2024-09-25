;;;; 2.65
;; Use the results of exercises 2.63 and 2.64 to give $\Theta(n)$ implementations of `union-set` and `intersection-set` for sets implemented as (balanced) binary trees.

;;; Answer
(load "2.binary-tree.scm") ; Load 2.63 and 2.64
;; Pred
(define (element-of-set? x set)
  (cond ((null? set) false)
        ((= x (entry set)) true)
        ((< x (entry set))
         (element-of-set? x (left-branch set)))
        ((> x (entry set))
         (element-of-set? x (right-branch set)))))
;; Proc
(define (adjoin-set x set)
  (cond ((null? set) (make-tree x '() '()))
        ((= x (entry set)) set)
        ((< x (entry set))
         (make-tree (entry set)
                    (adjoin-set x (left-branch set))
                    (right-branch set)))
        ((> x (entry set))
         (make-tree (entry set)
                    (left-branch set)
                    (adjoin-set x (right-branch set))))))
(define (intersection-set set1 set2)
  (list->tree
    (let iter ((set1 (tree->list set1))
               (set2 (tree->list set2)))
      (cond ((null? set1) '())
            ((null? set2) '())
            ((equal? (car set1) (car set2))
             (cons (car set1)
                   (iter (cdr set1) (cdr set2))))
            ((< (car set1) (car set2))
             (iter (cdr set1) set2))
            (else
              (iter set1 (cdr set2)))))))
(define (union-set set1 set2)
  (list->tree
    (let iter ((set1 (tree->list set1))
               (set2 (tree->list set2)))
      (cond ((null? set1) set2)
            ((null? set2) set1)
            ((equal? (car set1) (car set2))
             (cons (car set1) (iter (cdr set1) (cdr set2))))
            ((< (car set1) (car set2))
             (cons (car set1) (iter (cdr set1) set2)))
            (else
              (cons (car set2) (iter set1 (cdr set2))))))))

;; Test
(load "0.util.scm")
(define set1 (list->tree (list 1 3 5 7 9)))
(define set2 (list->tree (list 2 4 6 8 10)))
(define set3 (list->tree (list 3 5 7 9 11)))
(test (tree->list set1) (list 1 3 5 7 9))
(test (union-set set1 set2) (list->tree (list 1 2 3 4 5 6 7 8 9 10)))
(test (union-set set1 set3) (list->tree (list 1 3 5 7 9 11)))
(test (intersection-set set1 set2) (list->tree ()))
(test (intersection-set set1 set3) (list->tree (list 3 5 7 9)))

;; We combine $\Theta(n)$ `list->tree` and `tree->list` with our $\Theta(n)$ algorithm from Ex 2.62.
