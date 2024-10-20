;;;; 2.80
;; Define a generic predicate `=zero?` that tests if its argument is zero, and install it in the generic arithmetic package. This operation should work for ordinary numbers, rational numbers, and complex numbers.

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
(load "2.80.symbolic-=zero?.scm")
(install-symbolic-=zero?-package)
;; Test
(test (=zero? 0) true)
(test (=zero? (make-rational 0 10)) true)
(test (=zero? (make-complex-from-mag-ang 0 10)) true)
(test (=zero? (make-complex-from-real-imag 0 0)) true)
