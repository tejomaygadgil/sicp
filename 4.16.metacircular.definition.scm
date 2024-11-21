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
  (define (unassign def) ; Added
    (list (definition-variable def)
          '*unassigned*))
  (define (definition->assignment def) ; Added
    (make-assignment (definition-variable def)
                     (definition-value def)))
  (define (eval-definition exp env)
    (define-variable! (definition-variable exp)
                      (eval (definition-value exp) env)
                      env)
    'ok)
  ;; Install
  (put 'make 'define make-definition)
  (put 'proc 'unassign unassign)
  (put 'proc 'definition->assignment definition->assignment)
  (put 'eval 'define eval-definition)
  'ok)
;; Interface
(define (make-definition variable value)
  ((get 'make 'define) variable value))
(define (unassign def)
  ((get 'proc 'unassign) def))
(define (definition->assignment def)
  ((get 'proc 'definition->assignment) def))
