;; Cons
(define (make-binding variable value)
  (cons variable value))
;; Sel
(define (binding-variable binding)
  (car binding))
(define (binding-value binding)
  (cdr binding))
;; Proc
(define (binding-in-frame variable frame)
  (assoc variable frame))
(define (extend variable value frame)
  (cons (make-binding variable value) frame))
;; Obj
(define the-empty-frame '())
