(define (install-lisp-value-package)
  (put 'lisp-value 'qeval
       (lambda (call frame)
         (let ((result
                (execute
                 (instantiate call
                              frame
                              (lambda (v f)
                                (error "Unknown pat var -- LISP-VALUE" v))))))
           (require result)
           frame)))
  'ok)

(define (execute exp)
  (apply (eval (predicate exp))
         (args exp)))

(define (predicate exps)
  (car exps))

(define (args exps)
  (cdr exps))
