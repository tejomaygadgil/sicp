;;;; 2.83
;; Suppose you are designing a generic arithmetic system for dealing with the tower of types shown in figure 2.25: integer, rational, real, complex. For each type (except complex), design a procedure that raises objects of that type one level in the tower. Show how to install a generic `raise` operation that will work for each type (except complex).

;; Test
(load "0.util.scm")
(load "2.data-directed.scm")
(load "2.symbolic-tagged-data.scm")
(load "2.symbolic-interface.scm")
(load "2.symbolic-scheme-number.scm")
(load "2.symbolic-rational.scm")
(load "2.symbolic-real-number.scm")
(load "2.symbolic-complex.scm")
(define *op-table* (make-hash-table))
(install-symbolic-scheme-number-package)
(install-symbolic-rational-package)
(install-symbolic-real-number-package)
(install-symbolic-complex-package)
(load "2.complex-rectangular.scm")
(load "2.complex-polar.scm")
(install-complex-rectangular-package)
(install-complex-polar-package)
;; Install package
(load "2.83.symbolic-raise.scm")
(install-symbolic-raise-package)
;; Test
(test (raise 4) (make-rational 4 1))
(test (raise (make-rational 1 2)) 0.5)
(test (raise 0.5) (make-complex-from-real-imag 0.5 0))
