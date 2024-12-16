(define (install-save-restore-package)
 ;;; Stack record
  ;; Cons
  (define (make-stack-record name value)
    (cons name value))
  ;; Sel
  (define (get-stack-record-name record)
    (car record))
  (define (get-stack-record-value record)
    (cadr record))
 ;;; Inst
  ;; Sel
  (define (stack-inst-reg-name inst)
    (cadr inst))
  ;; Proc
  (define (make-save inst labels machine
                     pc flag stack ops)
    (let* ((reg-name (stack-inst-reg-name inst))
           (reg (get-register machine reg-name)))
      (lambda ()
        (push stack (make-stack-record reg-name (get-contents reg)))
        (advance-pc pc))))
  (define (make-restore inst labels machine
                        pc flag stack ops)
    (let* ((reg-name (stack-inst-reg-name inst))
           (reg (get-register machine reg-name)))
      (lambda ()
        (let* ((stack-record (pop stack))
               (stack-name (get-stack-record-name stack-record)))
          (if (eq? reg-name stack-name)
              (begin (set-contents! reg (get-stack-record-value stack-record))
                     (advance-pc pc))
              (error "Register mismatch -- RESTORE" stack-name reg-name))))))
  ;; Install
  (put 'exec 'save make-save)
  (put 'exec 'restore make-restore)
  'done)
