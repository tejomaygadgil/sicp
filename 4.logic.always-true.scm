(define (install-always-true-package)
  ;; Proc
  (define (always-true ignore frame-stream) frame-stream)
  ;; Install
  (put 'always-true 'qeval always-true)
  'ok)
