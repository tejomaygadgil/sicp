(define (install-if-package)
  ;; Cons
  (define (make-if predicate consequent alternative)
    (list 'if predicate consequent alternative))
  ;; Sel
  (define (if-predicate exp) (cadr exp))
  (define (if-consequent exp) (caddr exp))
  (define (if-alternative exp)
    (if (not (null? (cdddr exp)))
      (cadddr exp)
      'false))
  ;; Proc
  (define (eval-if exp env)
    (if (true? (eval (if-predicate exp) env))
      (eval (if-consequent exp) env)
      (eval (if-alternative exp) env)))
  ;; Install
  (put 'make 'if make-if)
  (put 'eval 'if eval-if)
  'ok)
;; Interface
(define (make-if predicate consequent alternative)
  ((get 'make 'if) predicate consequent alternative))
