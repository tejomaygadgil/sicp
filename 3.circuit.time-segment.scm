;; Cons
(define (make-time-segment time queue)
  (cons time queue))
;; Sel
(define (segment-time s) (car s))
(define (segment-queue s) (cdr s))
