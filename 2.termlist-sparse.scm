;; Sel
(define (first-term term-list) (car term-list))
(define (rest-terms term-list) (cdr term-list))
;; Pred
(define (empty-termlist? term-list) (null? term-list))
;; Proc
(define (adjoin-term term term-list)
  (if (=zero? (coeff term))
      term-list
      (cons term term-list)))
;; Obj
(define (the-empty-termlist) '())
