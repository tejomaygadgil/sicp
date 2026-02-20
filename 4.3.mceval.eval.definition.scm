(define (install-definition-package)
  (put 'eval 'define
       (lambda (exp env)
         (define-variable! (definition-variable exp)
           (eval (definition-value exp) env)
           env)
         'ok))
  'ok)

(define (definition-variable exp)
  (if (symbol? (cadr exp))
      (cadr exp)
      (caadr exp)))

(define (definition-value exp)
  (if (symbol? (cadr exp))
      (caddr exp)
      (make-lambda (cdadr exp)   ; formal parameters
                   (cddr exp)))) ; body

(define (make-definition variable value)
  (list 'define variable value))
