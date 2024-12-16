(define (install-perform-package)
  ;; Sel
  (define (perform-action inst)
    (cdr inst))
  ;; Proc
  (define (make-perform inst labels machine
                     pc flag stack ops)
    (let ((action (perform-action inst)))
      (if (operation-exp? action)
          (let ((action-proc
                  (make-operation-exp
                    action machine labels ops)))
            (lambda ()
              (action-proc)
              (advance-pc pc)))
          (error "Bad PERFORM instruction -- ASSEMBLE" inst))))
  ;; Install
  (put 'exec 'perform make-perform)
  'done)
