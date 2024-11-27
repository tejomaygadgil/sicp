(define (install-assignment-package)
  ;; Cons
  (define (make-assignment variable value)
    (list 'set! variable value))
  ;; Sel
  (define (assignment-variable exp) (cadr exp))
  (define (assignment-value exp) (caddr exp))
  ;; Proc
  (define (analyze-assignment exp) ; Changed
    (let ((var (assignment-variable exp))
          (vproc (analyze (assignment-value exp))))
      (lambda (env succeed fail)
        (vproc env
               (lambda (val fail2)         ; *1*
                 (let ((old-value
                         (lookup-variable-value var env)))
                   (set-variable-value! var val env)
                   (succeed 'ok
                            (lambda ()     ; *2*
                              (set-variable-value! var
                                                   old-value
                                                   env)
                              (fail2)))))
               fail))))
  ;; Install
  (put 'make 'set! make-assignment)
  (put 'eval 'set! analyze-assignment)
  'ok)
;; Interface
(define (make-assignment variable value)
  ((get 'make 'set!) variable value))
