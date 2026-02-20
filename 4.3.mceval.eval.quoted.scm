(define (install-quotation-package)
  (put 'eval 'quote
       (lambda (exp env) (text-of-quotation exp)))
  'ok)

(define (text-of-quotation exp)
  (cadr exp))
