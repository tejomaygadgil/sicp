;; Cons
(define (make-stack)
  (let ((s '()))
    (define (push x)
      (set! s (cons x s)))
    (define (pop)
      (if (null? s)
          (error "Empty stack -- POP")
          (let ((top (car s)))
            (set! s (cdr s))
            top)))
    (define (initialize)
      (set! s '())
      'done)
    (define (dispatch m)
      (cond ((eq? m 'push) push)
            ((eq? m 'pop) (pop))
            ((eq? m 'initialize) (initialize))
            (else
              (error "Unknown request -- STACK" m))))
    dispatch))
;; Interface
(define (pop stack)
  (stack 'pop))
(define (push stack val)
  ((stack 'push) val))
