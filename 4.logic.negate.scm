(define (install-negate-package)
  ;; Sel
  (define (negated-query exps) (car exps))
  ;; Proc
  (define (negate operands frame-stream)
    (stream-flatmap
     (lambda (frame)
       (if (stream-null? (qeval (negated-query operands)
                                (singleton-stream frame)))
           (singleton-stream frame)
           the-empty-stream))
     frame-stream))
  ;; Install
  (put 'not 'qeval negate)
  'ok)
