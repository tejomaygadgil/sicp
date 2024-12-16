(define (install-branch-package)
  ;; Sel
  (define (branch-dest inst)
    (cadr inst))
  ;; Proc
  (define (make-branch inst labels machine
                     pc flag stack ops)
    (let ((dest (branch-dest inst)))
      (if (label-exp? dest)
          (let ((insts
                  (lookup-label labels
                                (label-exp-label dest))))
            (lambda ()
              (if (get-contents flag)
                  (set-contents! pc insts)
                  (advance-pc pc))))
          (error "Bad BRANCH instruction -- ASSEMBLE" inst))))
  ;; Install
  (put 'exec 'branch make-branch)
  'done)
