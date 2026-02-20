(define (install-load-package)
  (put 'eval 'load
       (lambda (exp env)
         (eval-sequence (read-file (cadr exp)) env)))
  'ok)
