(define (install-symbolic-project-package)
  ;; Data abstractions
  ;; Install
  (put 'project '(rational)
       (lambda (x)
         (include "2.rational.scm")
         (make-scheme-number (round (/ (numer x) (denom x))))))
  (put 'project '(real-number)
       (lambda (x) (make-rational (round->exact x) 1)))
  (put 'project '(complex)
       (lambda (x)
         (include "2.complex-abstraction.scm")
         (real-part x))) ; (*)
  'done)
;; Interface
(define (project x)
  (apply-generic 'project x))
