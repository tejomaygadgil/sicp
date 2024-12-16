(define (install-save-restore-package)
  ;; Sel
  (define (stack-inst-reg-name inst)
    (cadr inst))
  ;; Proc
  (define (make-save inst labels machine
                     pc flag stack ops)
    (let ((reg (get-register machine
                             (stack-inst-reg-name inst))))
      (lambda ()
        (push stack (get-contents reg))
        (advance-pc pc))))
  (define (make-restore inst labels machine
                        pc flag stack ops)
    (let ((reg (get-register machine
                             (stack-inst-reg-name inst))))
      (lambda ()
        (set-contents! reg (pop stack))
        (advance-pc pc))))
  ;; Install
  (put 'exec 'save make-save)
  (put 'exec 'restore make-restore)
  'done)
