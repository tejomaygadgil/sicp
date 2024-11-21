(define (install-lambda-package)
  ;; Cons
  (define (make-lambda parameters body)
    (cons 'lambda (cons parameters body)))
  ;; Sel
  (define (lambda-parameters exp) (cadr exp))
  (define (lambda-body exp) (cddr exp))
  ;; Install
  (put 'make 'lambda make-lambda)
  (put 'eval 'lambda (lambda (exp env) (make-procedure (lambda-parameters exp)
                                                       (lambda-body exp) env)))
  'ok)
;; Interface
(define (make-lambda parameters body)
  ((get 'make 'lambda) parameters body))
