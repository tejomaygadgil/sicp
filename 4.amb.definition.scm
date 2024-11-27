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
  (define (analyze-definition exp) ; Changed
    (let ((var (definition-variable exp))
          (vproc (analyze (definition-value exp))))
      (lambda (env succeed fail)
        (vproc env
               (lambda (val fail2)
                 (define-variable! var val env)
                 (succeed 'ok fail2))
               fail))))
  ;; Install
  (put 'make 'define make-definition)
  (put 'eval 'define analyze-definition)
  'ok)
;; Interface
(define (make-definition variable value)
  ((get 'make 'define) variable value))
