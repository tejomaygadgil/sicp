(define (install-assignment-package)
  ;; Cons
  (define (make-assignment variable value)
    (list 'set! variable value))
  ;; Sel
  (define (assignment-variable exp) (cadr exp))
  (define (assignment-value exp) (caddr exp))
  ;; Proc
  (define (analyze-assignment exp)
    (let ((var (assignment-variable exp)) ; Has to be a name!
          (vproc (analyze (assignment-value exp))))
      (lambda (env)
        (set-variable-value! var (vproc env) env)
        'ok)))
  ;; Install
  (put 'make 'set! make-assignment)
  (put 'eval 'set! analyze-assignment)
  'ok)
;; Interface
(define (make-assignment variable value)
  ((get 'make 'set!) variable value))
