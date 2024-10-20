;; Sel
(define (numer x) (car x))
(define (denom x) (cdr x))
;; Cons
(define (make-rat n d) ; Data-directed
  (apply-generic 'reduce n d))
