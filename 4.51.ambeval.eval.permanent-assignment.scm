(define (install-permanent-set!-package)
  (put 'eval 'permanent-set!
       (lambda (exp)
         (let ((var (assignment-variable exp))
               (vproc (analyze (assignment-value exp))))
           (lambda (env succeed fail)
             (vproc env
                    (lambda (val fail2)
                      (set-variable-value! var val env)
                      (succeed 'ok
                               fail2)) ; Do not revert
                    fail)))))
  'ok)
