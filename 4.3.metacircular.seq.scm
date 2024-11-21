;; Sel
(define (first-exp seq) (car seq))
(define (rest-exps seq) (cdr seq))
;; Pred
(define (last-exp? seq) (null? (cdr seq)))
