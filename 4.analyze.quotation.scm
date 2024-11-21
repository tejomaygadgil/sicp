(define (install-quotation-package)
  ;; Sel
  (define (text-of-quotation exp) (cadr exp))
  ;; Proc
  (define (analyze-quotation exp)
    (let ((qval (text-of-quotation exp)))
    (lambda (env) qval)))
  ;; Install
  (put 'eval 'quote analyze-quotation)
  'ok)
