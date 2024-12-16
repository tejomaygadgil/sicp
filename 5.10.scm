;;;; 5.10
;; Design a new syntax for register-machine instructions and modify the simulator to use your new syntax. Can you implement your new syntax without changing any part of the simulator except the syntax procedures in this section?

;;; Answer
(define recursive-expt
  '(define recursive-expt
     (make-machine
       '(base product counter continue)
       (list (list '= =)
             (list '- -)
             (list '* *))
       '((assign (reg continue) (label expt-done)) ; Specify (reg continue)
         expt-loop
           (test (op =) (reg counter) (const 0))
           (branch (label base-case))
           (save continue)
           (save counter)
           (assign (reg counter) (op -) (reg counter) (const 1))
           (assign (reg continue) (label after-expt))
           (goto (label expt-loop))
         after-expt
           (restore counter)
           (restore continue)
           (assign (reg product) (op *) (reg product) (reg base))
           (goto (reg continue))
         base-case
          (assign (reg product) (const 1))
          (goto (reg continue))
         expt-done))))

;; Test
(load "5.10.register-machine.scm")
(define base 2)
(define power 8)
(eval-and-print
  (list recursive-expt
        '(set-register-contents! recursive-expt 'base base)
        '(set-register-contents! recursive-expt 'counter power)
        '(start recursive-expt)
        '(get-register-contents recursive-expt 'product)))
