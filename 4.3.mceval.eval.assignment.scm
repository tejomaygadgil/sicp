(define (install-assignment-package)
  (put 'eval 'set!
       (lambda (exp env)
         (set-variable-value! (assignment-variable exp)
                              (eval (assignment-value exp) env)
                              env)
         'ok))
  'ok)

(define (assignment-variable exp)
  (cadr exp))

(define (assignment-value exp)
  (caddr exp))

(define (make-assignment variable value)
  (list 'set! variable value))
