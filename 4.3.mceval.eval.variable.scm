(define (install-variable-package)
  (put 'eval 'variable
       (lambda (exp env)
         (lookup-variable-value exp env)))
  'ok)

(define (variable? exp)
  (symbol? exp))
