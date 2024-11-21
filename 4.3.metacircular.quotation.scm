(define (install-quotation-package)
  ;; Sel
  (define (text-of-quotation exp) (cadr exp))
  ;; Install
  (put 'eval 'quote (lambda (exp env) (text-of-quotation exp)))
  'ok)
