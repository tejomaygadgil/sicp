(define (install-assign-package)
  ;; Sel
  (define (reg-name inst)
    (cadr (register-exp-reg inst))) ; Changed
  (define (value-exp inst)
    (cddr inst))
  ;; Proc
  (define (make-assign inst labels machine
                       pc flag stack ops)
    (let ((reg (get-register machine
                             (reg-name inst)))
          (exp (value-exp inst)))
      (let ((value-proc
              (if (operation-exp? exp)
                  (make-operation-exp exp machine labels ops)
                  (make-primitive-exp (car exp) machine labels))))
        (lambda ()
          (set-contents! reg (value-proc))
          (advance-pc pc)))))
  ;; Install
  (put 'exec 'assign make-assign)
  'done)
