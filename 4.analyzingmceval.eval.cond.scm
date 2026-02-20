(define (install-cond-package)
  (put 'eval 'cond
       (lambda (exp)
         (analyze (cond->if exp))))
  'ok)
