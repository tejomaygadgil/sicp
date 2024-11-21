;;;; 4.5
;; Scheme allows an additional syntax for `cond` clauses, `(<test> => <recipient>)`. If `<test>` evaluates to a true value, then `<recipient>` is evaluated. Its value must be a procedure of one argument; this procedure is then invoked on the value of the `<test>`, and the result is returned as the value of the `cond` expression. For example
;;
;; (cond ((assoc 'b '((a 1) (b 2))) => cadr)
;;       (else false))
;;
;; returns 2. Modify the handling of `cond` so that it supports this extended syntax.

;;; Answer
(define (install-cond-package)
  (include "4.3.metacircular.seq.scm")
  ;; cond-=>
  (define (cond-=>? clause)
    (eq? (cadr clause) '=>))
  (define (cond-=>-proc clause)
    (caddr clause))
  (define (cond-=>->exp first)
    (list (cond-=>-proc first) (cond-predicate first)))
  ;; Cons
  (define (make-cond clauses)
    (cons 'cond clauses))
  ;; Sel
  (define (cond-clauses exp) (cdr exp))
  (define (cond-predicate clause) (car clause))
  (define (cond-actions clause) (cdr clause))
  ;; Pred
  (define (cond-else-clause? clause)
    (eq? (cond-predicate clause) 'else))
  ;; Proc
  (define (cond->if exp)
    (expand-clauses (cond-clauses exp)))
  (define (expand-clauses clauses)
    (if (null? clauses)
      'false                          ; no else clause
      (let ((first (car clauses))
            (rest (cdr clauses)))
        (if (cond-else-clause? first)
          (if (null? rest)
            (sequence->exp (cond-actions first))
            (error "ELSE clause isn't last -- COND->IF"
                   clauses))
          (make-if (cond-predicate first)
                   (sequence->exp (cond-actions first))
                   (expand-clauses rest))))))
  (define (sequence->exp seq)
    (cond ((null? seq) seq)
          ((last-exp? seq) (first-exp seq))
          (else (make-begin seq))))
  ;; Install
  (put 'eval 'cond (lambda (exp env) (eval (cond->if exp) env)))
  'ok)
;; Interface
(define (make-cond clauses)
  ((get 'make 'cond) clauses))
