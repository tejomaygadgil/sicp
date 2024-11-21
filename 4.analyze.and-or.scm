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
  (define (analyze-and exp)
    (analyze (and->if exp)))
  (define (analyze-or exp)
    (analyze (or->if exp)))
  ;; Install
  (put 'make 'and make-and)
  (put 'make 'and make-or)
  (put 'eval 'and analyze-and)
  (put 'eval 'or analyze-or)
  'ok)
;; Interface
(define (make-and clauses)
  ((get 'make 'and) clauses))
(define (make-or clauses)
  ((get 'make 'or) clauses))
