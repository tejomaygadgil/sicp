(define (install-quotation-package)
  ;; Sel
  (define (text-of-quotation exp) (cadr exp))
  ;; Proc
  (define (analyze-quotation exp) ; Changed
    (let ((qval (text-of-quotation exp)))
      (lambda (env succeed fail)
        (succeed qval fail))))
  ;; Install
  (put 'eval 'quote analyze-quotation)
  'ok)
