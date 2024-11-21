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
                     (cddr exp)))) ; body (creates cons!)
  ;; Proc
  (define (analyze-definition exp)
    (let ((var (definition-variable exp)) ; Has to be a name!
          (vproc (analyze (definition-value exp))))
      (lambda (env)
        (define-variable! var (vproc env) env)
        'ok)))
  ;; Install
  (put 'make 'define make-definition)
  (put 'eval 'define analyze-definition)
  'ok)
;; Interface
(define (make-definition variable value)
  ((get 'make 'define) variable value))
