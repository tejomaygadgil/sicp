(define (install-unique-package)
  (put 'unique 'qeval
       (lambda (contents frame-stream)
         (stream-flatmap
          (lambda (frame)
            (let ((res (qeval (unique-query contents)
                              (singleton-stream frame))))
              (if (and (not (stream-null? res))
                       (stream-null? (stream-cdr res)))
                  res
                  the-empty-stream)))
          frame-stream)))
  'ok)

(define (unique-query exps)
  (car exps))
