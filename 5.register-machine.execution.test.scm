(define (install-test-package)
  ;; Sel
  (define (test-condition inst)
    (cdr inst))
  ;; Proc
  (define (make-test inst labels machine
                     pc flag stack ops)
    (let ((condition (test-condition inst)))
      (if (operation-exp? condition)
          (let ((condition-proc
                  (make-operation-exp
                    condition machine labels ops)))
            (lambda ()
              (set-contents! flag (condition-proc))
              (advance-pc pc)))
          (error "Bad TEST instruction -- ASSEMBLE" inst))))
  ;; Install
  (put 'exec 'test make-test)
  'done)
