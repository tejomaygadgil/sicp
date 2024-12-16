;;;; 5.7
;; Use the simulator to test the machines you designed in exercise 5.4.

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
           (assign product (op *) (reg product) (reg base))
           (goto (reg continue))
         base-case
          (assign product (const 1))
          (goto (reg continue))
         expt-done))))
(define iterative-expt
  '(define iterative-expt
     (make-machine
       '(base counter product)
       (list (list '= =)
             (list '- -)
             (list '* *))
       '((assign product (const 1))
         expt-loop
           (test (op =) (reg counter) (const 0))
           (branch (label expt-done))
           (assign counter (op -) (reg counter) (const 1))
           (assign product (op *) (reg product) (reg base))
           (goto (label expt-loop))
         expt-done))))

;; Test
(load "5.register-machine.scm")
(define base 2)
(define power 8)
(eval-and-print
  (list recursive-expt
        '(set-register-contents! recursive-expt 'base base)
        '(set-register-contents! recursive-expt 'counter power)
        '(start recursive-expt)
        '(get-register-contents recursive-expt 'product)))
(newline)
(eval-and-print
  (list iterative-expt
        '(set-register-contents! iterative-expt 'base base)
        '(set-register-contents! iterative-expt 'counter power)
        '(start iterative-expt)
        '(get-register-contents iterative-expt 'product)))
