(define (install-lisp-value-package)
  ;; Sel
  (define (predicate exps) (car exps))
  (define (args exps) (cdr exps))
  ;; Proc
  (define (execute exp)
    (apply (eval (predicate exp) user-initial-environment)
           (args exp)))
  (define (lisp-value call frame-stream)
    (simple-stream-flatmap ; Changed
     (lambda (frame)
       (if (execute
            (instantiate
             call
             frame
             (lambda (v f)
               (error "Unknown pat var -- LISP-VALUE" v))))
           (singleton-stream frame)
           the-empty-stream))
     frame-stream))
  ;; Install
  (put 'lisp-value 'qeval lisp-value)
  'ok)
