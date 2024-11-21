(define (install-begin-package)
  (include "4.3.metacircular.seq.scm")
  ;; Cons
  (define (make-begin seq) (cons 'begin seq))
  ;; Sel
  (define (begin-actions exp) (cdr exp))
  ;; Proc
  (define (eval-sequence exps env)
    (cond ((last-exp? exps) (eval (first-exp exps) env))
          (else (eval (first-exp exps) env)
                (eval-sequence (rest-exps exps) env))))
  ;; Install
  (put 'make 'begin make-begin)
  (put 'eval 'eval-sequence eval-sequence)
  (put 'eval 'begin (lambda (exp env) (eval-sequence (begin-actions exp) env)))
  'ok)
;; Interface
(define (make-begin seq)
  ((get 'make 'begin) seq))
(define (eval-sequence exps env)
  ((get 'eval 'eval-sequence) exps env))
