(define (install-symbolic-equ?-package)
  ;; Install
  (put 'equ? '(scheme-number scheme-number) equal?)
  (put 'equ? '(rational rational)
       (lambda (x y)
         (include "2.rational.scm")
         (and (equal? (numer x) (numer y))
              (equal? (denom x) (denom y)))))
  (put 'equ? '(real-number real-number) equal?)
  (put 'equ? '(complex complex)
       (lambda (x y)
         (include "2.complex-abstraction.scm")
         (and (= (real-part x) (real-part y))
              (= (imag-part x) (imag-part y)))))
  'done)
;; Interface
(define (equ? x y)
  (apply-generic 'equ? x y))
