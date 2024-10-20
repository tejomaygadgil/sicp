(define (install-symbolic-no-drop-package)
  ;; Install
  (put 'no-drop 'raise true) ; (*)
  'done)
