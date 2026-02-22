(define (install-unless-package)
  (put 'eval 'unless
       (lambda (exp env)
         (eval (unless->if exp) env)))
  'ok)

(define (unless-condition exp)
  (cadr exp))

(define (unless-usual-val exp)
  (caddr exp))

(define (unless-exception exp)
  (cadddr exp))

(define (unless->if exp)
  (make-if (unless-condition exp)
           (unless-exception exp)
           (unless-usual-val exp)))
