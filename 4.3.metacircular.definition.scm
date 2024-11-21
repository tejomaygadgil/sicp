(define (install-definition-package)
  ;; Cons
  (define (make-definition variable value)
    (list 'define variable value))
  ;; Sel
  (define (definition-variable exp)
    (if (symbol? (cadr exp))
      (cadr exp)
      (caadr exp)))
  (define (definition-value exp)
    (if (symbol? (cadr exp))
      (caddr exp)
      (make-lambda (cdadr exp)   ; formal parameters
                   (cddr exp)))) ; body
  ;; Proc
  (define (eval-definition exp env)
    (define-variable! (definition-variable exp)
                      (eval (definition-value exp) env)
                      env)
    'ok)
  ;; Install
  (put 'make 'define make-definition)
  (put 'eval 'define eval-definition)
  'ok)
;; Interface
(define (make-definition variable value)
  ((get 'make 'define) variable value))
