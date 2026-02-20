(define (install-variable-package)
  (put 'eval 'variable
       (lambda (exp)
         (lambda (env)
           (lookup-variable-value exp env))))
  'ok)
