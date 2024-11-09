;;;; 3.35
;; Ben Bitdiddle tells Louis that one way to avoid the trouble in exercise 3.34 is to define a squarer as a new primitive constraint. Fill in the missing portions in Ben's outline for a procedure to implement such a constraint:
;;
;; (define (squarer a b)
;;   (define (process-new-value)
;;     (if (has-value? b)
;;         (if (< (get-value b) 0)
;;             (error "square less than 0 -- SQUARER" (get-value b))
;;             <alternative1>)
;;         <alternative2>))
;;   (define (process-forget-value) <body1>)
;;   (define (me request) <body2>)
;;   <rest of definition>
;;   me)


;;; Answer
;; 3.35 Squarer constraint
(define (squarer a b)
  (define (process-new-value)
    (if (has-value? b)
        (if (< (get-value b) 0)
            (error "square less than 0 -- SQUARER" (get-value b))
            (set-value! a
                        (sqrt (get-value b))
                        me))
        (if (has-value? a)
            (set-value! b
                        (expt (get-value a) 2)
                        me))))
  (define (process-forget-value)
    (forget-value! a me)
    (forget-value! b me)
    (process-new-value))
  (define (me request)
    (cond ((eq? request 'I-have-a-value)
           (process-new-value))
          ((eq? request 'I-lost-my-value)
           (process-forget-value))
          (else
           (error "Unknown request -- SQUARER" request))))
  (connect a me)
  (connect b me)
  me)

;; ==== Test ====
(load "0.util.scm")
(load "3.constraint.scm")
(squarer x1 x2)
(set-value! x2 16 'user)
(newline)
(test (get-value x1) 4)
(forget-value! x2 'user)
(set-value! x1 3 'user)
(newline)
(test (get-value x2) 9)
