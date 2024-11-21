(define (install-self-evaluating-package)
  ;; Pred
  (define (self-evaluating? exp)
    (cond ((number? exp) true)
          ((string? exp) true)
          (else false)))
  ;; Proc
  (define (analyze-self-evaluating exp)
    (lambda (env) exp))
  ;; Install
  (put 'pred 'self-evaluating? self-evaluating?)
  (put 'eval 'self-evaluating analyze-self-evaluating)
  'ok)
;; Interface
(define (self-evaluating? exp)
  ((get 'pred 'self-evaluating?) exp))
