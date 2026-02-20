(define (remove-binding-from-frame! var frame)
  (set-car! frame (make-binding nil nil))
  'ok)
