(define (eval exp env)
  ((analyze exp) env))
(define (analyze exp)
  ((or (get 'eval
            (cond ((self-evaluating? exp) 'self-evaluating)
                  ((variable? exp) 'variable)
                  (else (operator exp))))
       (if (application? exp)
           analyze-application
           (error "Unknown expression -- ANALYZE" exp)))
   exp))
