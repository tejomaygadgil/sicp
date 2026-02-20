(define (install-and-or-package)
  (put 'eval 'and
       (lambda (exp)
         (analyze (and->if exp))))
  (put 'eval 'or
       (lambda (exp)
         (analyze (or->if exp))))
  'ok)
