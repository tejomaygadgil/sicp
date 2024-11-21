;;;; 4.4
;; Recall the definitions of the special forms `and` and `or` from chapter 1:
;;
;; * `and:` The expressions are evaluated from left to right. If any expression evaluates to false, false is returned; any remaining expressions are not evaluated. If all the expressions evaluate to true values, the value of the last expression is returned. If there are no expressions then true is returned.
;; * `or:` The expressions are evaluated from left to right. If any expression evaluates to a true value, that value is returned; any remaining expressions are not evaluated. If all expressions evaluate to false, or if there are no expressions, then false is returned.
;;
;; Install `and` and `or` as new special forms for the evaluator by defining appropriate syntax procedures and evaluation procedures `eval-and` and `eval-or`. Alternatively, show how to implement `and` and `or` as derived expressions.

;;; Answer
;; Derived expression
(define (install-and-or-package)
  ;; Cons
  (define (make-and clauses)
    (cons 'and clauses))
  (define (make-or clauses)
    (cons 'or clauses))
  ;; Proc
  (define (logical-clauses exp) (cdr exp))
  (define (expand-clauses-and clauses)
    (let ((first (car clauses))
          (rest (cdr clauses)))
      (make-if first
               (if (null? rest)
                 first
                 (expand-clauses-and rest))
               'false)))
  (define (expand-clauses-or clauses)
    (let ((first (car clauses))
          (rest (cdr clauses)))
      (make-if first
               first
               (if (null? rest)
                 'false
                 (expand-clauses-or rest)))))
  (define (and->if exp)
    (expand-clauses-and (logical-clauses exp)))
  (define (or->if exp)
    (expand-clauses-or (logical-clauses exp)))
  ;; Install
  (put 'make 'and make-and)
  (put 'make 'and make-or)
  (put 'eval 'and (lambda (exp env) (eval (and->if exp) env)))
  (put 'eval 'or (lambda (exp env) (eval (or->if exp) env)))
  'ok)
;; Interface
(define (make-and clauses)
  ((get 'make 'and) clauses))
(define (make-or clauses)
  ((get 'make 'or) clauses))

;; ;; Special form
;; ;; Abstraction
;; (define (logical-iter return-pred exp env)
;;   (define (iter exp env)
;;     (let ((result (eval (car exp) env))
;;           (rest (cdr exp)))
;;       (if (null? rest) result
;;         (if (return-pred result)
;;           result
;;           (iter rest env)))))
;;   (iter exp env))
;; (define (logical-seq exp)
;;   (cdr exp))
;; (define (eval-and exp env)
;;     (logical-iter false? (logical-seq exp) env))
;; (define (eval-or exp env)
;;   (logical-iter true? (logical-seq exp) env))
;; ;; Install
;; (define (install-and-or)
;;   (put *metacircular-table* 'eval 'and eval-and)
;;   (put *metacircular-table* 'eval 'or eval-or)
;;   'ok)
;; ;; Test
;; (load "0.util.scm")
;; (test (eval (list 'and (list > 1 0) (list > 10 1)) 'env) 'true)
;; (test (eval (list 'and (list > 1 0) (list < 10 1)) 'env) 'false)
;; (test (eval (list 'and (list < 1 0) (list < 10 1)) 'env) 'false)
;; (test (eval (list 'or (list > 1 0) (list > 10 1)) 'env) 'true)
;; (test (eval (list 'or (list > 1 0) (list < 10 1)) 'env) 'true)
;; (test (eval (list 'or (list < 1 0) (list < 10 1)) 'env) 'false)
