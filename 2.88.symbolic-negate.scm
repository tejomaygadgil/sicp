(define (install-symbolic-negate-package)
  ;; Install
  (put 'no-drop 'negate true) ; cf. `no-drop` in 2.85.scm
  (put 'negate '(scheme-number)
       (lambda (x) (make-scheme-number (* -1 x))))
  (put 'negate '(rational)
       (lambda (x)
         (include "2.rational.scm")
         (make-rational (* -1 (numer x)) (denom x))))
  (put 'negate '(real-number)
       (lambda (x) (make-real-number (* x -1.))))
  (put 'negate '(complex)
       (lambda (x)
         (include "2.complex-abstraction.scm")
         (let ((x-type (type-tag x)))
           (cond ((equal? x-type 'polar) ; Direct dispatch, could be abstracted
                  (make-complex-from-mag-ang (negate (magnitude x))
                                             (angle x)))
                 ((equal? x-type 'rectangular)
                  (make-complex-from-real-imag (negate (real-part x))
                                               (imag-part x)))))))
  (put 'negate '(polynomial)
       (lambda (x)
         (include "2.term.scm") ; order, coeff, make-term
         (include "2.88.termlist-negate-terms.scm") ; negate-terms
         (include "2.polynomial-abstraction.scm") ; variable, term-list, make-poly
         (make-polynomial (variable x)
                          (negate-terms (term-list x)))))
  'done)
;; Interface
(define (negate x)
  (apply-generic 'negate x))
