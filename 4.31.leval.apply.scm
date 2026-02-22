(define (apply procedure arguments env)
  (cond ((primitive-procedure? procedure)
         (apply-primitive-procedure
          procedure
          (list-of-arg-values arguments env)))
        ((compound-procedure? procedure)
         (eval-sequence
          (procedure-body procedure)
          (extend-environment
           (procedure-parameters procedure) ;; Changed
           (list-of-delayed-args procedure ;; Changed
                                 arguments
                                 env)
           (procedure-environment procedure))))
        (else
         (error
          "Unknown procedure type -- APPLY" procedure))))

(define (list-of-delayed-args proc exps env)
  (let loop ((pars (procedure-signature proc))
             (exps exps))
    (if (no-operands? exps) '()
        (cons (delay-it (first-parameter pars)
                        (first-operand exps)
                        env)
              (loop (rest-parameters pars)
                    (rest-operands exps))))))

(define (procedure-parameters procedure)
  (let loop ((parameters (procedure-signature procedure)))
    (if (null? parameters) '()
        (cons (parameter-name (first-parameter parameters))
              (loop (rest-parameters parameters))))))

(define (procedure-signature procedure)
  (cadr procedure))

(define (first-parameter parameters)
  (car parameters))

(define (rest-parameters parameters)
  (cdr parameters))

(define (parameter-name parameter)
  (if (pair? parameter)
      (car parameter)
      parameter))

(define (parameter-type parameter)
  (if (pair? parameter)
      (cadr parameter)
      'eager))
