(define (install-until-package)
  (put 'eval 'until
       (lambda (exp env)
         (eval (until->let exp) env)))
  'ok)

(define (until-pred exp)
  (cadr exp))

(define (until-body exp)
  (cddr exp))

(define (until->let exp)
  (make-named-let 'iter
                  '((acc nil))
                  (make-if (until-pred exp) 'acc
                           `(iter ,(make-begin (until-body exp))))))

(define (make-until pred body)
  (cons 'until (cons pred body)))
