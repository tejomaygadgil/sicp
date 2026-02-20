(define (install-self-evaluating-package)
  (put 'eval 'self-evaluating
       (lambda (exp)
         (lambda (env) exp)))
  'ok)
