(define (install-lisp-value-package)
  (put 'lisp-value 'qeval
       (lambda (call frame-stream)
         (stream-flatmap
          (lambda (frame)
            (if (execute
                 (instantiate
                  call
                  frame
                  (lambda (v f)
                    (error "Unknown pat var -- LISP-VALUE" v))))
                (singleton-stream frame)
                the-empty-stream))
          frame-stream)))
  'ok)

(define (execute exp)
  (apply (eval (predicate exp) user-initial-environment)
         (args exp)))

(define (predicate exps)
  (car exps))

(define (args exps)
  (cdr exps))
