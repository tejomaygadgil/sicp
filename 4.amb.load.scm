(define (install-load-package)
  ;; Proc
  (define (analyze-load exp) ; Changed
    (let ((lproc (analyze-sequence (read-file (cadr exp)))))
      (lambda (env succeed fail)
        (succeed (lproc env succeed fail) fail))))
  ;; Install
  (put 'eval 'load analyze-load)
  'ok)
