;;;; 2.79
;; Define a generic equality predicate `equ?` that tests the equality of two numbers, and install it in the generic arithmetic package. This operation should work for ordinary numbers, rational numbers, and complex numbers.

;;; Answer
(define (install-symbolic-equ?-package)
  ;; Install
  (put 'equ? '(scheme-number scheme-number) equal?)
  (put 'equ? '(rational rational)
       (lambda (x y)
         (include "2.rational.scm")
         (and (equal? (/ (numer x) (gcd (numer x) (denom x)))
                      (/ (numer y) (gcd (numer y) (denom y))))
              (equal? (/ (denom x) (gcd (numer x) (denom x)))
                      (/ (denom y) (gcd (numer y) (denom y)))))))
  (put 'equ? '(real-number real-number) equal?)
  (put 'equ? '(complex complex)
       (lambda (x y)
         (include "2.complex-abstraction.scm")
         (and (equ? (real-part x) (real-part y)) ; (*)
              (equ? (imag-part x) (imag-part y)))))
  'done)
;; Interface
(define (equ? x y)
  (apply-generic 'equ? x y))
