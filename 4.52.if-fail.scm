(define (install-if-fail-package)
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
  (define (analyze-if-fail exp)
    (let ((sproc (analyze (if-predicate exp))) ; Success branch
          (fproc (analyze (if-consequent exp)))) ; Failure branch
      (lambda (env succeed fail)
        (sproc env
               succeed ; Continue success branch
               (lambda () ; Divert to failure branch
                 (fproc env
                        succeed
                        fail))))))
  ;; Install
  (put 'eval 'if-fail analyze-if-fail)
  'ok)
