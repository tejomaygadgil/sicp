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
  (define (analyze-if exp)
    (let ((pproc (analyze (if-predicate exp)))
          (cproc (analyze (if-consequent exp)))
          (aproc (analyze (if-alternative exp))))
      (lambda (env succeed fail)
        (pproc env
               (lambda (pred-value fail2)
                 (if (true? pred-value)
                   (cproc env succeed fail2)
                   (aproc env succeed fail2)))
               fail))))
  ;; Install
  (put 'make 'if make-if)
  (put 'eval 'if analyze-if)
  'ok)
;; Interface
(define (make-if predicate consequent alternative)
  ((get 'make 'if) predicate consequent alternative))
