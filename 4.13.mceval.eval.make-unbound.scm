(define (install-make-unbound-package)
  (put 'eval 'make-unbound!
       (lambda (exp env)
         (make-unbound! (make-unbound-variable exp)
                        env)
         'ok))
  'ok)

(define (make-unbound-variable exp)
  (cadr exp))
