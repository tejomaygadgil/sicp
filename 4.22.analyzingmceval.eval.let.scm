(define (install-let-package)
  (put 'eval 'let
       (lambda (exp)
         (analyze (let->combination exp))))
  'ok)
