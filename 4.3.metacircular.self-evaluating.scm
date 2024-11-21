(define (install-self-evaluating-package)
  ;; Pred
  (define (self-evaluating? exp)
    (cond ((number? exp) true)
          ((string? exp) true)
          (else false)))
  ;; Proc
  (define (self-evaluating exp env) exp)
  ;; Install
  (put 'pred 'self-evaluating? self-evaluating?)
  (put 'eval 'self-evaluating self-evaluating)
  'ok)
;; Interface
(define (self-evaluating? exp)
  ((get 'pred 'self-evaluating?) exp))
