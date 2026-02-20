(define (install-cond-package)
  (put 'eval 'cond
       (lambda (exp env)
         (eval (cond->if exp) env)))
  'ok)

;; =>
(define (cond-=>? clause)
  (eq? (cadr clause) '=>))

(define (cond-=>-proc clause)
  (caddr clause))

(define (cond-=>-exp clause)
  (list (cond-=>-proc clause)
        (cond-predicate clause)))

;; cond
(define (cond-clauses exp)
  (cdr exp))

(define (cond-else-clause? clause)
  (eq? (cond-predicate clause) 'else))

(define (cond-predicate clause)
  (car clause))

(define (cond-actions clause)
  (cdr clause))

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
                     (if (cond-=>? first)
                         (cond-=>-exp first)
                         (sequence->exp (cond-actions first)))
                     (expand-clauses rest))))))
