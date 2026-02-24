(define (install-if-fail-package)
  (put 'eval 'if-fail
       (lambda (exp)
         (let ((pproc (analyze (if-predicate exp)))
               (cproc (analyze (if-consequent exp))))
           (lambda (env succeed fail)
             (pproc env
                    succeed ;; Continue success branch
                    (lambda () ;; Divert to failure branch
                      (cproc env
                             succeed
                             fail)))))))
  'ok)
