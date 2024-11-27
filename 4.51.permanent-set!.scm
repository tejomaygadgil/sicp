;; Install
(define (install-permanent-set!-package)
  ;; Cons
  (define (make-assignment variable value)
    (list 'set! variable value))
  ;; Sel
  (define (assignment-variable exp) (cadr exp))
  (define (assignment-value exp) (caddr exp))
  ;; Proc
  (define (analyze-permanent-assignment exp)
    (let ((var (assignment-variable exp))
          (vproc (analyze (assignment-value exp))))
      (lambda (env succeed fail)
        (vproc env
               (lambda (val fail2)
                 (set-variable-value! var val env)
                 (succeed 'ok
                          fail2)) ; Do not revert
               fail))))
  ;; Install
  (put 'eval 'permanent-set! analyze-permanent-assignment)
  'ok)
