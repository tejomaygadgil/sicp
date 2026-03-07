(define (install-negate-package)
  (put 'not 'qeval
       (lambda (operands frame)
         (waive (qeval (negated-query operands)
                       (amb frame)))
         frame))
  'ok)

(define (negated-query exps)
  (car exps))
