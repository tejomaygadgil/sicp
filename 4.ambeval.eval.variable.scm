(define (install-variable-package)
  (put 'eval 'variable
       (lambda (exp)
         (lambda (env succeed fail)
           (succeed (lookup-variable-value exp env)
                    fail))))
  'ok)
