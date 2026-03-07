(define (install-negate-package)
  (put 'not 'qeval
       (lambda (operands frame-stream)
         (stream-flatmap
          (lambda (frame)
            (if (stream-null? (qeval (negated-query operands)
                                     (singleton-stream frame)))
                (singleton-stream frame)
                the-empty-stream))
          frame-stream)))
  'ok)

(define (negated-query exps)
  (car exps))
