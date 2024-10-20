;; Sel
(define (variable p) (car p))
(define (term-list p) (cdr p))
;; Cons
(define (make-poly variable term-list)
  (cons variable term-list))
