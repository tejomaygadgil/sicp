(define (apply procedure arguments env)
  (define (get-symbols parameters)
    (map get-symbol parameters))
  (define (get-values parameters)
    (map (lambda (parameter argument)
           (cond ((applicative? parameter)
                  (actual-value argument env))
                 ((lazy? parameter)
                  (delay-it-naive argument env))
                 ((lazy-memo? parameter)
                  (delay-it argument env))
                 (else (error "Unknown parameter type -- GET-VALUES"
                              parameter))))
         parameters arguments))
  (cond ((primitive-procedure? procedure)
         (apply-primitive-procedure
           procedure
           (list-of-arg-values arguments env)))
        ((compound-procedure? procedure)
         (eval-sequence
           (procedure-body procedure)
           (extend-environment
             (get-symbols (procedure-parameters procedure)) ; Changed
             (get-values (procedure-parameters procedure)) ; Changed
             (procedure-environment procedure))))
        (else
          (error
            "Unknown procedure type -- APPLY" procedure))))
