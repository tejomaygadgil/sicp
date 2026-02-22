(define (install-if-package)
  (put 'eval 'if
       (lambda (exp env)
         (if (true? (actual-value (if-predicate exp) env))
             (eval (if-consequent exp) env)
             (eval (if-alternative exp) env))))
  'ok)
