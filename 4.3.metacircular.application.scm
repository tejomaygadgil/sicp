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
(define (list-of-values exps env)
  (if (no-operands? exps)
    '()
    (cons (eval (first-operand exps) env)
          (list-of-values (rest-operands exps) env))))
