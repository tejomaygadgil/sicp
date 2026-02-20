(define (install-while-package)
  (put 'eval 'while
       (lambda (exp env)
         (eval (while->until exp) env)))
  'ok)

(define (while-pred exp)
  (cadr exp))

(define (while-body exp)
  (cddr exp))

(define (while->until exp)
  (make-until `(not ,(while-pred exp))
              (while-body exp)))
