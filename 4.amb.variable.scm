(define (install-variable-package)
  ;; Pred
  (define (variable? exp) (symbol? exp))
  ;; Proc
  (define (analyze-variable exp) ; Changed
    (lambda (env succeed fail)
      (succeed (lookup-variable-value exp env)
               fail)))
  ;; Install
  (put 'pred 'variable? variable?)
  (put 'eval 'variable analyze-variable)
  'ok)
;; Interface
(define (variable? exp)
  ((get 'pred 'variable?) exp))
