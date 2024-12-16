;; Sel
(define (real-part z) (apply-generic 'real-part z))
(define (imag-part z) (apply-generic 'imag-part z))
(define (magnitude z) (apply-generic 'magnitude z))
(define (angle z) (apply-generic 'angle z))
;; Cons
(define (make-from-mag-ang r a)
  ((get 'make-from-mag-ang 'polar) r a))
(define (make-from-real-imag x y)
  ((get 'make-from-real-imag 'rectangular) x y))
