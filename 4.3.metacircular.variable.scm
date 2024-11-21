(define (install-variable-package)
  ;; Pred
  (define (variable? exp) (symbol? exp))
  ;; Proc
  (define (variable exp env) (lookup-variable-value exp env))
  ;; Install
  (put 'pred 'variable? variable?)
  (put 'eval 'variable variable)
  'ok)
;; Interface
(define (variable? exp)
  ((get 'pred 'variable?) exp))
