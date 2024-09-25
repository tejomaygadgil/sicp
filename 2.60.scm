;;;; 2.60
;; We specified that a set would be represented as a list with no duplicates. Now suppose we allow duplicates. For instance, the set ${1, 2, 3}$ could be represented as the list $(2 3 2 1 3 2 2)$. Design procedures `element-of-set?`, `adjoin-set`, `union-set`, and `intersection-set` that operate on this representation. How does the efficiency of each compare with the corresponding procedure for the non-duplicate representation? Are there applications for which you would use this representation in preference to the non-duplicate one?

;;; Answer
(load "2.59.scm")
;; Proc
(define (adjoin-set x set)
  (cons x set))
(define (union-set set1 set2)
  (append set1 set2))

;; Test
(load "0.util.scm")
(define S (list 1 1 2 3))
(define T (list 3 3 4 5 5))
(define U (list 6 7 8))
(test (element-of-set? 4 S) false)
(test (element-of-set? 4 T) true)
(test (element-of-set? 4 (union-set T U)) true)
(test (adjoin-set 4 S) (cons 4 S))
(test (adjoin-set 4 T) (cons 4 T))
(test (union-set S S) (append S S))
(test (union-set S ()) S)
(test (union-set () S) S)
(test (intersection-set S T) (list 3))
(test (intersection-set T S) (list 3 3))
(test (intersection-set S U) ())
(test (intersection-set T U) ())

;; | Operation | Unique | Duplicates |
;; |---|---|---|
;; | `element-of-set?` | $\Theta(n)$ | $\Theta(n)$ |
;; | `adjoin-set` | $\Theta(n)$ | $\Theta(1)$ |
;; | `intersection-set` | $\Theta(n^2)$ | $\Theta(n^2)$ |
;; | `union-set` | $\Theta(n^2)$ | $\Theta(n)$ |

;; This data abstraction defers computation to selection time, complementing scenarios that require quick storage and infrequent retrieval such as archival systems.
