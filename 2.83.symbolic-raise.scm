(define (install-symbolic-raise-package)
  ;; Install
  (put 'raise '(scheme-number)
       (lambda (x) (make-rational x 1)))
  (put 'raise '(rational)
       (lambda (x)
         (include "2.rational.scm")
         (make-real-number (/ (numer x) (denom x)))))
  (put 'raise '(real-number)
       (lambda (x) (make-complex-from-real-imag x 0)))
  'done)
;; Interface
(define (raise x)
  (apply-generic 'raise x))
