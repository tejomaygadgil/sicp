(define (install-waive-package)
  (put 'eval 'waive
       (lambda (exp)
         (let ((pproc (analyze (waive-predicate exp))))
           (lambda (env succeed fail)
             (pproc env
                    (lambda (value fail2)
                      (fail))
                    (lambda ()
                      (succeed 'ok fail)))))))
  'ok)

(define (waive-predicate exp)
  (cadr exp))
