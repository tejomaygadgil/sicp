(define (install-variable-package)
  ;; Pred
  (define (variable? exp) (symbol? exp))
  ;; Proc
  (define (analyze-variable exp)
    (lambda (env) (lookup-variable-value exp env)))
  ;; Install
  (put 'pred 'variable? variable?)
  (put 'eval 'variable analyze-variable)
  'ok)
;; Interface
(define (variable? exp)
  ((get 'pred 'variable?) exp))
