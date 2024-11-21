;;;; 4.10.
;; By using data abstraction, we were able to write an `eval` procedure that is independent of the particular syntax of the language to be evaluated. To illustrate this, design and implement a new syntax for Scheme by modifying the procedures in this section, without changing `eval` or `apply`.

;;; Answer
(define (operator exp)
  (if (equal? (car exp) 'please)
    (cadr exp)
    (error "Say please -- OPERATOR" exp)))
(define (operands exp)
  (if (equal? (car exp) 'please)
    (cddr exp)
    (error "Say please -- OPERANDS" exp)))
(define (make-procedure parameters body env)
  (list 'please 'procedure parameters body env))
(define (make-if predicate consequent alternative)
  (list 'please 'if predicate consequent alternative))
(define (make-lambda parameters body)
  (list 'please 'lambda (cons parameters body)))
(define (make-begin seq)
  (list 'please 'begin seq))
(define (make-let defs body)
  (list 'please 'let defs body))
(define (make-named-let name defs body)
  (list 'please 'let name defs body))
