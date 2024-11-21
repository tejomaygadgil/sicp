(define (install-load-package)
  ;; Proc
  (define (analyze-load exp)
    (let ((lproc (analyze-sequence (read-file (cadr exp)))))
      (lambda (env) (lproc env))))
  ;; Install
  (put 'eval 'load analyze-load)
  'ok)
