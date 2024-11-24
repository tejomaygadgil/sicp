(define (install-unless)
  ;; Sel
  (define (unless-condition exp) (cadr exp))
  (define (unless-usual-val exp) (caddr exp))
  (define (unless-exception exp) (cadddr exp))
  ;; Proc
  (define (unless->if exp)
    (make-if (unless-condition exp)
             (unless-exception exp)
             (unless-usual-val exp)))
  ;; Install
  (put 'eval 'unless (lambda (exp env) (eval (unless->if exp) env)))
  'ok)
