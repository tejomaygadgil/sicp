(define (install-load-package)
  (put 'eval 'load
       (lambda (exp)
         (let ((lproc (analyze-sequence (read-file (cadr exp)))))
           (lambda (env succeed fail)
             (succeed (lproc env succeed fail) fail)))))
  'ok)
