(define (install-load-package)
  (put 'eval 'load
       (lambda (exp)
         (let ((lproc (analyze-sequence (read-file (cadr exp)))))
           (lambda (env) (lproc env)))))
  'ok)
