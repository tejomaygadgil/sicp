(define (install-lambda-package)
  (put 'eval 'lambda
       (lambda (exp)
         (let ((vars (lambda-parameters exp))
               (bproc (analyze-sequence (lambda-body exp))))
           (lambda (env succeed fail)
             (succeed (make-procedure vars bproc env)
                      fail)))))
  'ok)
