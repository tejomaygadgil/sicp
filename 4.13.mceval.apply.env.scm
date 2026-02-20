(define (make-unbound! var env)
  (remove-binding-from-frame!
   var (scan-bindings var (first-frame env))))
