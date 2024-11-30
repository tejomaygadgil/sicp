;; Cons
(define (make-hist) the-empty-hist)
(define (make-sig query frame)
  (map (lambda (x) (if (var? exp)
                       (let ((binding (binding-in-frame exp frame)))
                         (if binding
                             (binding-value binding)
                             binding))
                       exp))
       query))
;; Sel
(define (in-hist? sig)
  (member sig hist))
(define (out-of-tries?)
  (> tries tries-limit))
;; Mut
(define (add-to-hist! sig)
  (set! hist (cons sig hist)))
(define (add-to-tries!)
  (set! tries (1+ tries)))
(define (reset-hist!)
  (set! hist the-empty-hist)
  (set! tries 0))
;; Obj
(define the-empty-hist '())
