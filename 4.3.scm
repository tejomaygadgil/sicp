;;;; 4.3
;; Rewrite `eval` so that the dispatch is done in data-directed style. Compare this with the data-directed differentiation procedure of exercise 2.73. (You may use the `car` of a compound expression as the type of the expression, as is appropriate for the syntax implemented in this section.) .

;;; Answer
(load "0.table.scm")
(load "4.3.metacircular.eval.scm")
(load "4.3.metacircular.application.scm")
;; Prim
(load "4.3.metacircular.self-evaluating.scm")
(load "4.3.metacircular.variable.scm")
(load "4.3.metacircular.quotation.scm")
;; Special form
(load "4.3.metacircular.assignment.scm")
(load "4.3.metacircular.definition.scm")
(load "4.3.metacircular.if.scm")
(load "4.3.metacircular.lambda.scm")
(load "4.3.metacircular.begin.scm")
(load "4.3.metacircular.cond.scm")
;; Install
(define *op-table* (make-hash-table))
(install-self-evaluating-package)
(install-variable-package)
(install-quotation-package)
(install-assignment-package)
(install-definition-package)
(install-if-package)
(install-lambda-package)
(install-begin-package)
(install-cond-package)

;; Test
(load "0.util.scm")
;; Cons
(let ((variable 'x)
      (value 1))
  (test (make-assignment variable value)
        (list 'set! variable value))
  (test (make-definition variable value)
        (list 'define variable value)))
(let ((predicate 'true)
      (consequent 1)
      (alternative 0))
  (test (make-if predicate consequent alternative)
        (list 'if predicate consequent alternative)))
(let ((parameters '(x))
      (body '(+ x 1)))
  (test (make-lambda parameters body)
        (cons 'lambda (cons parameters body))))
(let ((clauses '((+ x 1) x)))
  (test (make-begin clauses)
        (cons 'begin clauses)))
(let ((clauses '((true 1) (false 0) (else (error "Error!")))))
  (test (make-cond clauses)
        (cons 'cond clauses)))
;; Prim
(test (eval 1 'env) 1)
(test (eval (quote 'test) 'env) 'test)
