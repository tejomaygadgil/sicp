;; Sel
(define (order term) (car term))
(define (coeff term) (cadr term))
;; Cons
(define (make-term order coeff) (list order coeff))
