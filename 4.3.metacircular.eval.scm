(define (eval exp env) ; Expression is either
  (let ((prim-spec
          (lambda (exp)
            (get 'eval (cond ((self-evaluating? exp) 'self-evaluating)
                             ((variable? exp) 'variable)
                             (else (operator exp))))))
        (apply-compound
          (lambda (exp env)
            (apply (eval (operator exp) env)
                   (list-of-values (operands exp) env)))))
    ((or (prim-spec exp) ; Primitive or special form
         apply-compound) ; Application
     exp env)))
