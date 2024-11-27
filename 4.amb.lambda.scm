(define (install-lambda-package)
  ;; Cons
  (define (make-lambda parameters body)
    (cons 'lambda (cons parameters body)))
  ;; Sel
  (define (lambda-parameters exp) (cadr exp))
  (define (lambda-body exp) (cddr exp))
  ;; Proc
  (define (analyze-lambda exp) ; Changed
    (let ((vars (lambda-parameters exp))
          (bproc (analyze-sequence (lambda-body exp))))
      (lambda (env succeed fail)
        (succeed (make-procedure vars bproc env)
                 fail))))
  ;; Install
  (put 'make 'lambda make-lambda)
  (put 'eval 'lambda analyze-lambda)
  'ok)
;; Interface
(define (make-lambda parameters body)
  ((get 'make 'lambda) parameters body))
