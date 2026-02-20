(define (install-let*-package)
  (put 'eval 'let*
       (lambda (exp env)
         (eval (let*->nested-lets exp) env)))
  'ok)

(define (let*->nested-lets exp)
  (let inner ((exp (cdr exp)))
    (let ((defs (car exp))
          (body (cadr exp)))
      (if (null? defs) body
          (let ((first-def (car defs))
                (rest-defs (cdr defs)))
            (make-let (list first-def)
                      (list (inner (list rest-defs body)))))))))
