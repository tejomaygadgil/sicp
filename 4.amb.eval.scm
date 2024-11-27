(define (ambeval exp env succeed fail) ; n.b. execution procedure!
  ((analyze exp) env succeed fail)) ; Changed
(define (analyze exp)
  ((or (get 'eval
            (cond ((self-evaluating? exp) 'self-evaluating)
                  ((variable? exp) 'variable)
                  (else (operator exp))))
       (if (application? exp)
           analyze-application
           (error "Unknown expression -- ANALYZE" exp)))
   exp))
