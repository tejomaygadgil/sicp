;; Obj
(define the-empty-environment '())
;; Sel
(define (first-frame env) (car env))
(define (enclosing-environment env) (cdr env))
;; Proc
(define (extend-environment vars vals base-env)
  (if (= (length vars) (length vals))
      (cons (make-frame vars vals) base-env)
      (if (< (length vars) (length vals))
          (error "Too many arguments supplied" vars vals)
          (error "Too few arguments supplied" vars vals))))
(define (scan-env var env)
  (let iter ((env env))
    (if (eq? env the-empty-environment) false
      (let ((binding (scan-frame var (first-frame env))))
          (if (false? binding)
            (iter (enclosing-environment env))
            binding)))))
