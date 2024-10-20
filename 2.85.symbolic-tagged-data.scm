;; Sel
(define (type-tag datum)
  (cond ((pair? datum) (car datum))
        ((number? datum) (if (exact? datum) 'scheme-number 'real-number))
        (else 'not-found))) ; Graceful failure (*)
(define (contents datum)
  (cond ((pair? datum) (cdr datum))
        ((number? datum) datum)
        (error "Bad tagged datum -- CONTENTS" datum)))
;; Pred
(define (not-found? val)
  (equal? val 'not-found))
;; Cons
(define (attach-tag type-tag contents)
  (cond ((number? contents) contents)
        (else (cons type-tag contents))))
