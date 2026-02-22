(define (eval exp env)
  (mc-mess-eval exp) ;; 4.mceval.extra.scm
  ((or (get 'eval
            (cond ((self-evaluating? exp) 'self-evaluating)
                  ((variable? exp) 'variable)
                  (else (operator exp))))
       (if (application? exp)
           (lambda (exp env)
             (let ((procedure (actual-value (operator exp) env))
                   (arguments (operands exp)))
               (mc-mess-apply procedure arguments) ;; 4.mceval.extra.scm
               (apply procedure arguments env)))
           (error "Unknown expression -- EVAL" exp)))
   exp env))

(define (actual-value exp env)
  (force-it (eval exp env)))
