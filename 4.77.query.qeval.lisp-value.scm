(define (install-lisp-value-package)
  (put 'lisp-value 'qeval
       (lambda (call frame-stream)
         (stream-flatmap
          (lambda (frame)
            (let ((exp (args call)))
              (let ((miss-proc
                     (lambda (frame)
                       (missing-bindings? (args call) frame)))
                    (test-proc
                     (lambda (frame)
                       (execute
                        (instantiate call
                                     frame
                                     (lambda (v f)
                                       (error "Unknown pat var -- LISP-VALUE" v)))))))
                (cond ((miss-proc frame)
                       (singleton-stream
                        (add-promise (cons-promise miss-proc test-proc) frame)))
                      ((test-proc frame) (singleton-stream frame))
                      (else the-empty-stream)))))
          frame-stream)))
  'ok)
