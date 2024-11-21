(define (install-cond-package)
  (include "4.3.metacircular.seq.scm")
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
  (put 'make 'cond make-cond)
  (put 'eval 'cond (lambda (exp env) (eval (cond->if exp) env)))
  'ok)
;; Interface
(define (make-cond clauses)
  ((get 'make 'cond) clauses))
