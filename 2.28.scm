;;;; 2.28
;; Write a procedure fringe that takes as argument a tree (represented as a list) and returns a list whose elements are all the leaves of the tree arranged in left-to-right order. For example,
;;
;; (define x (list (list 1 2) (list 3 4)))
;;
;; (fringe x)
;; (1 2 3 4)
;;
;; (fringe (list x x))
;; (1 2 3 4 1 2 3 4)

;;; Answer
(define (fringe tree)
  (cond ((null? tree) '())
        ((not (pair? tree)) (list tree))
        (else (append (fringe (car tree))
                      (fringe (cdr tree)))))) ; Beautiful

;; Test
(load "0.util.scm")
(define x '((1 (7 2)) (3 4)))
(test (fringe (list x x)) '(1 7 2 3 4 1 7 2 3 4))
