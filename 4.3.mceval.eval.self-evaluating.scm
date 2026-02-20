(define (install-self-evaluating-package)
  (put 'eval 'self-evaluating
       (lambda (exp env) exp))
  'ok)

(define (self-evaluating? exp)
  (cond ((number? exp) true)
        ((string? exp) true)
        (else false)))
