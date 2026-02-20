(define (install-for-package)
  (put 'eval 'for
       (lambda (exp env)
         (eval (for->let exp) env)))
  'ok)

(define (for-var exp)
  (caadr exp))

(define (for-list exp)
  (list-ref (cadr exp) 2))

(define (for-body exp)
  (cddr exp))

(define (for->let exp)
  (make-let `((proc ,(make-lambda (list (for-var exp))
                                  (for-body exp))))
            (list
             (make-named-let 'iter
                             `((x ,(for-list exp))
                               (acc nil))
                             (make-if '(null? x) 'acc
                                      '(iter (cdr x)
                                             (append acc
                                                     (list (proc (car x))))))))))
