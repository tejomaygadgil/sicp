(define (install-complex-polar-package)
  ;; internal procedures
  (include "2.86.complex-trigonometry.scm")
  ;; Sel
  (define (real-part z)
    (x-coord (magnitude z) (angle z))) ; (*)
  (define (imag-part z)
    (y-coord (magnitude z) (angle z))) ; (*)
  (define (magnitude z) (car z))
  (define (angle z) (cdr z))
  ;; Cons
  (define (make-from-real-imag x y)
    (cons (euclidean-distance x y) (angle-from-coords x y))) ; (*)
  (define (make-from-mag-ang r a) (cons r a))
  ;; interface to the rest of the system
  (define (tag x) (attach-tag 'polar x))
  (put 'real-part '(polar) real-part)
  (put 'imag-part '(polar) imag-part)
  (put 'magnitude '(polar) magnitude)
  (put 'angle '(polar) angle)
  (put 'make-from-real-imag 'polar
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'polar
       (lambda (r a) (tag (make-from-mag-ang r a))))
  'done)
