(define (install-unique-package)
  ;; Sel
  (define (unique-query exps) (car exps))
  ;; Proc
  (define (uniquely-asserted contents frame-stream)
    (stream-flatmap
     (lambda (frame)
       (let ((res (qeval (unique-query contents)
                         (singleton-stream frame))))
         (if (and (not (stream-null? res))
                  (stream-null? (stream-cdr res)))
             res
             the-empty-stream)))
     frame-stream))
  ;; Install
  (put 'unique 'qeval uniquely-asserted)
  'ok)
