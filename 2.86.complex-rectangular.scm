(define (install-complex-rectangular-package)
  ;; internal procedures
  (include "2.86.complex-trigonometry.scm")
  ;; Sel
  (define (real-part z) (car z))
  (define (imag-part z) (cdr z))
  (define (magnitude z)
    (euclidean-distance (real-part z) (imag-part z))) ; (*)
  (define (angle z)
    (angle-from-coords (real-part z) (imag-part z))) ; (*)
  ;; Cons
  (define (make-from-real-imag x y) (cons x y))
  (define (make-from-mag-ang r a)
    (cons (x-coord r a) (y-coord r a))) ; (*)
  ;; interface to the rest of the system
  (define (tag x) (attach-tag 'rectangular x))
  (put 'real-part '(rectangular) real-part)
  (put 'imag-part '(rectangular) imag-part)
  (put 'magnitude '(rectangular) magnitude)
  (put 'angle '(rectangular) angle)
  (put 'make-from-real-imag 'rectangular
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'rectangular
       (lambda (r a) (tag (make-from-mag-ang r a))))
  'done)
