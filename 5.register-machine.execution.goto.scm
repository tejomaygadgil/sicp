(define (install-goto-package)
  ;; Sel
  (define (goto-dest inst)
    (cadr inst))
  ;; Proc
  (define (make-goto inst labels machine
                     pc flag stack ops)
    (let ((dest (goto-dest inst)))
      (cond ((label-exp? dest)
             (let ((insts
                     (lookup-label labels
                                   (label-exp-label dest))))
               (lambda () (set-contents! pc insts))))
            ((register-exp? dest)
             (let ((reg
                     (get-register machine
                                   (register-exp-reg dest))))
               (lambda ()
                 (set-contents! pc (get-contents reg)))))
            (else
              (error "Bad GOTO instruction -- ASSEMBLE" inst)))))
  ;; Install
  (put 'exec 'goto make-goto)
  'done)
