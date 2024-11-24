;; Sel
(define (operator exp)
  (if (pair? exp) (car exp)
    (error "Unknown expression type -- OPERATOR" exp)))
(define (operands exp) (cdr exp))
(define (first-operand ops) (car ops))
(define (rest-operands ops) (cdr ops))
;; Pred
(define (application? exp) (pair? exp))
(define (no-operands? ops) (null? ops))
;; Proc
(define (list-of-arg-values exps env) ; Changed
  (map (lambda (exp) (actual-value exp env))
       exps))
(define (list-of-delayed-args exps env) ; Changed
  (map (lambda (exp) (delay-it exp env))
       exps))
