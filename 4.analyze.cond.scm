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
  (define (analyze-cond exp)
    (analyze (cond->if exp)))
  ;; Install
  (put 'eval 'cond analyze-cond)
  'ok)
;; Interface
(define (make-cond clauses)
  ((get 'make 'cond) clauses))
