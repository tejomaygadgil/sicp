(define (install-always-true-package)
  (put 'always-true 'qeval
       (lambda (ignore frame-stream)
         frame-stream))
  'ok)
