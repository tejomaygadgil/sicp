;;;; 2.62
;; Give $\theta(n)$ implementation of `union-set` for sets represented as ordered lists.

;; | Operation | Unordered (unique) | Unordered (duplicated) | Ordered |
;; |---|---|---|---|
;; | `element-of-set?` | $\Theta(n)$ | $\Theta(n)$ | $\Theta(n)$ |
;; | `adjoin-set` | $\Theta(n)$ | $\Theta(1)$ | $\Theta(n)$ |
;; | `intersection-set` | $\Theta(n^2)$ | $\Theta(n^2)$ | $\Theta(n)$ |
;; | `union-set` | $\Theta(n^2)$ | $\Theta(n)$ | $\Theta(n)$ |

;;; Answer
(load "2.61.scm")
(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        ((= (car set1) (car set2))
         (cons (car set1)
           (union-set (cdr set1) (cdr set2))))
        ((< (car set1) (car set2))
         (cons (car set1)
               (union-set (cdr set1) set2)))
        (else (cons (car set2)
                    (union-set set1 (cdr set2))))))

;; Test
(load "0.util.scm")
(define S (list 0 1 2 3))
(define T (list 2 3 4 5))
(define U (list 6 7 8 9))
(test (union-set (list 1 3 5 7 9) (list 2 4 6 8 10)) (list 1 2 3 4 5 6 7 8 9 10))
(test (union-set S T) (list 0 1 2 3 4 5))
(test (union-set U S) (list 0 1 2 3 6 7 8 9))
(test (union-set (list 1) (list 2)) (list 1 2))
(test (union-set S S) S)
(test (union-set S ()) S)
(test (union-set () S) S)
