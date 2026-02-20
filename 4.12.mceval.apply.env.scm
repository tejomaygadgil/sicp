(define (env-loop var env)
  (let loop ((env env))
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (let ((frame (scan-bindings var (first-frame env))))
          (if frame frame
              (loop (enclosing-environment env)))))))

(define (scan-bindings var frame)
  (cond ((null? frame) false)
        ((eq? var (var-binding (first-binding frame))) frame)
        (else (scan-bindings var (rest-bindings frame)))))

(define (lookup-variable-value var env)
  (val-binding (first-binding (env-loop var env))))

(define (set-variable-value! var val env)
  (set-binding-to-frame! var val (env-loop var env)))

(define (define-variable! var val env)
  (let* ((frame (first-frame env))
         (result (scan-bindings var frame)))
    (if result
        (set-binding-to-frame! var val result)
        (add-binding-to-frame! var val frame))))
