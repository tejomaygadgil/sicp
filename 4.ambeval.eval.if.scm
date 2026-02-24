(define (install-if-package)
  (put 'eval 'if
       (lambda (exp)
         (let ((pproc (analyze (if-predicate exp)))
               (cproc (analyze (if-consequent exp)))
               (aproc (analyze (if-alternative exp))))
           (lambda (env succeed fail)
             (pproc env
                    (lambda (pred-value fail2)
                      (if (true? pred-value)
                          (cproc env succeed fail2)
                          (aproc env succeed fail2)))
                    fail)))))
  'ok)
