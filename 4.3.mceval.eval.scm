(define (eval exp env)
  (mc-mess-eval exp) ;; 4.mceval.extra.scm
  ((or (get 'eval
            (cond ((self-evaluating? exp) 'self-evaluating)
                  ((variable? exp) 'variable)
                  (else (operator exp))))
       (if (application? exp)
           (lambda (exp env)
             (let ((procedure (eval (operator exp) env))
                   (arguments (list-of-values (operands exp) env)))
               (mc-mess-apply procedure arguments) ;; 4.mceval.extra.scm
               (apply procedure arguments)))
           (error "Unknown expression -- EVAL" exp)))
   exp env))
