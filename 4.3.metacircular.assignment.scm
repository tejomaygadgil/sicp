(define (install-assignment-package)
  ;; Cons
  (define (make-assignment variable value)
    (list 'set! variable value))
  ;; Sel
  (define (assignment-variable exp) (cadr exp))
  (define (assignment-value exp) (caddr exp))
  ;; Proc
  (define (eval-assignment exp env)
    (set-variable-value! (assignment-variable exp)
                         (eval (assignment-value exp) env)
                         env)
    'ok)
  ;; Install
  (put 'make 'set! make-assignment)
  (put 'eval 'set! eval-assignment)
  'ok)
;; Interface
(define (make-assignment variable value)
  ((get 'make 'set!) variable value))
