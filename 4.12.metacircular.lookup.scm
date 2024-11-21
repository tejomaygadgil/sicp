(define (lookup-variable-value var env)
  (let ((result (scan-env var env)))
    (if result
      (cadr result)
      (error "Unbound variable -- LOOKUP-VARIABLE-VALUE" var))))
(define (set-variable-value! var val env)
  (let ((result (scan-env var env)))
    (if result
      (set-car! (cdr result) val)
      (error "Unbound variable -- SET-VARIABLE-VALUE!" var))))
(define (define-variable! var val env)
  (let ((frame (first-frame env)))
    (let ((result (scan-frame var frame)))
      (if result
        (set-car! (cdr result) val)
        (add-binding-to-frame! var val frame)))))
