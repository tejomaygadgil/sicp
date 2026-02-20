(define (install-quotation-package)
  (put 'eval 'quote
       (lambda (exp)
         (let ((qval (text-of-quotation exp)))
           (lambda (env) qval))))
  'ok)
