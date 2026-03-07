(define (install-negate-package)
  (put 'not 'qeval
       (lambda (operands frame-stream)
         (stream-flatmap
          (lambda (frame)
            (let ((miss-proc
                   (lambda (frame)
                     (missing-bindings? (negated-query operands) frame)))
                  (test-proc
                   (lambda (frame)
                     (stream-null? (qeval (negated-query operands)
                                          (singleton-stream frame))))))
              (cond ((miss-proc frame)
                     (singleton-stream
                      (add-promise (cons-promise miss-proc test-proc) frame)))
                    ((test-proc frame) (singleton-stream frame))
                    (else the-empty-stream))))
          frame-stream)))
  'ok)
