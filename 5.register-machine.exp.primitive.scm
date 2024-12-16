;; Sel
(define (register-exp-reg exp)
  (cadr exp))
(define (constant-exp-value exp)
  (cadr exp))
(define (label-exp-label exp)
  (cadr exp))
;; Pred
(define (register-exp? exp)
  (tagged-list? exp 'reg))
(define (constant-exp? exp)
  (tagged-list? exp 'const))
(define (label-exp? exp)
  (tagged-list? exp 'label))
;; Proc
(define (make-primitive-exp exp machine labels)
  (cond ((constant-exp? exp)
         (let ((c (constant-exp-value exp)))
           (lambda () c)))
        ((label-exp? exp)
         (let ((insts
                (lookup-label labels
                              (label-exp-label exp))))
           (lambda () insts)))
        ((register-exp? exp)
         (let ((r (get-register machine
                                (register-exp-reg exp))))
           (lambda () (get-contents r))))
        (else
         (error "Unknown expression type -- ASSEMBLE" exp))))
