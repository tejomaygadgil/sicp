;;;; 5.9
;; The treatment of machine operations above permits them to operate on labels as well as on constants and the contents of registers. Modify the expression-processing procedures to enforce the condition that operations can be used only with registers and constants.

;;; Answer
(define recursive-expt
  '(define recursive-expt
     (make-machine
       '(base product counter continue)
       (list (list '= =)
             (list '- -)
             (list '* *))
       '((assign continue (label expt-done))
         expt-loop
           (test (op =) (reg counter) (const 0))
           (branch (label base-case))
           (save continue)
           (save counter)
           (assign counter (op -) (reg counter) (const 1))
           (assign continue (label after-expt))
           (goto (label expt-loop))
         after-expt
           (restore counter)
           (restore continue)
           (perform (op print) (label after-expt)) ; Fail condition
           (assign product (op *) (reg product) (reg base))
           (goto (reg continue))
         base-case
          (assign product (const 1))
          (goto (reg continue))
         expt-done))))

;; Test
(load "5.9.register-machine.scm")
(define base 2)
(define power 8)
(eval-and-print
  (list recursive-expt
        '(set-register-contents! recursive-expt 'base base)
        '(set-register-contents! recursive-expt 'counter power)
        '(start recursive-expt)
        '(get-register-contents recursive-expt 'product)))
