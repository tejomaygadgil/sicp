(define (install-save-restore-package)
  ;; Sel
  (define (stack-inst-reg-name inst)
    (cadr inst))
  ;; Proc
  (define (make-save inst labels machine
                     pc flag stack ops)
    (let* ((reg-name (stack-inst-reg-name inst))
           (reg-stack (stack reg-name))
           (reg (get-register machine reg-name)))
      (lambda ()
        (push reg-stack (get-contents reg))
        (advance-pc pc))))
  (define (make-restore inst labels machine
                        pc flag stack ops)
    (let* ((reg-name (stack-inst-reg-name inst))
           (reg-stack (stack reg-name))
           (reg (get-register machine reg-name)))
      (lambda ()
        (set-contents! reg (pop reg-stack))
        (advance-pc pc))))
  ;; Install
  (put 'exec 'save make-save)
  (put 'exec 'restore make-restore)
  'done)
