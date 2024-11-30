(define (compound? exp) (pair? exp))

(define (constant? exp) (number? exp))

(define (variable? exp) (atom? exp))

(define (atom? x) (not (pair? x)))
