(define (install-and-or-package)
  (put 'eval 'and
       (lambda (exp env) (eval (and->if exp) env)))
  (put 'eval 'or
       (lambda (exp env) (eval (or->if exp) env)))
  'ok)

(define (logical-clauses exp)
  (cdr exp))

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

(define (make-and clauses)
  (cons 'and clauses))

(define (make-or clauses)
  (cons 'or clauses))
