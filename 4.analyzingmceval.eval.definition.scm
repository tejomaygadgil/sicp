(define (install-definition-package)
  (put 'eval 'define
       (lambda (exp)
         (let ((var (definition-variable exp))
               (vproc (analyze (definition-value exp))))
           (lambda (env)
             (define-variable! var (vproc env) env)
             'ok))))
  'ok)
