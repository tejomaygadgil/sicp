;;;; 2.79
;; Define a generic equality predicate `equ?` that tests the equality of two numbers, and install it in the generic arithmetic package. This operation should work for ordinary numbers, rational numbers, and complex numbers.

;; Test
(load "0.util.scm")
(load "0.table.scm")
(load "2.apply-generic.scm")
(load "2.symbolic-tagged-data.scm")
(load "2.symbolic-interface.scm")
(define *op-table* (make-hash-table))
(load "2.symbolic-scheme-number.scm")
(load "2.symbolic-rational.scm")
(load "2.symbolic-real-number.scm")
(load "2.symbolic-complex.scm")
(install-symbolic-scheme-number-package)
(install-symbolic-rational-package)
(install-symbolic-real-number-package)
(install-symbolic-complex-package)
(load "2.complex-rectangular.scm")
(load "2.complex-polar.scm")
(install-complex-rectangular-package)
(install-complex-polar-package)
;; Install package
(load "2.79.symbolic-equ?.scm")
(install-symbolic-equ?-package)
;; Test
(test (equ? 7 7) true)
(test (equ? (make-rational 1 2) (make-rational 2 4)) true)
(test (equ? (make-rational 1 2) (make-rational 2 3)) false)
(test (equ? (make-complex-from-mag-ang 1 0) (make-complex-from-real-imag 1 0)) true)
