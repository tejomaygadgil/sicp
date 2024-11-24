(define (eval exp env)
  (let ((prim-spec
          (lambda (exp)
            (get 'eval (cond ((self-evaluating? exp) 'self-evaluating)
                             ((variable? exp) 'variable)
                             ;; ((variable? exp) (force-it (lookup-variable-value exp env))) ; newone @ http://community.schemewiki.org/?sicp-ex-4.30
                             (else (operator exp))))))
        (apply-compound
          (lambda (exp env)
            (apply (actual-value (operator exp) env) ; Changed
                   (operands exp) ; Changed (do not evaluate!)
                   env))))
    ((or (prim-spec exp)
         apply-compound)
     exp env)))
