;;;; 2.94
;; Using `div-terms`, implement the procedure `remainder-terms` and use this to define `gcd-terms` as above. Now write a procedure `gcd-poly` that computes the polynomial GCD of two polys. (The procedure should signal an error if the two polys are not in the same variable.) Install in the system a generic operation `greatest-common-divisor` that reduces to `gcd-poly` for polynomials and to ordinary `gcd` for ordinary numbers. As a test, try
;;
;; (define p1 (make-polynomial 'x '((4 1) (3 -1) (2 -2) (1 2))))
;; (define p2 (make-polynomial 'x '((3 1) (1 -1))))
;; (greatest-common-divisor p1 p2)
;;
;; and check your result by hand.

;; ;;; Answer
;; By hand results (in Scheme syntax)
;; (greatest-common-divisor
;;   '(polynomial x (4 1) (3 -1) (2 -2) (1 2))
;;   '(polynomial x (3 1) (1 -1)))
;; (gcd-poly
;;   '(x (4 1) (3 -1) (2 -2) (1 2))
;;   '(x (3 1) (1 -1)))
;; (gcd-terms
;;   '((4 1) (3 -1) (2 -2) (1 2))
;;   '((3 1) (1 -1)))
;; (gcd-terms
;;   '((3 1) (1 -1))
;;   '((2 -1) (1 1)))
;; (gcd-terms
;;   '((2 -1) (1 1)))
;;   '())
;; '(polynomial x sparse (2 -1) (1 1)))

;; Test
(load "0.util.scm")
(load "0.table.scm")
(load "2.85.symbolic-tagged-data.scm")
(load "2.symbolic-interface.scm")
(define *op-table* (make-hash-table))
(load "2.symbolic-scheme-number.scm")
(load "2.symbolic-real-number.scm")
(load "2.symbolic-complex.scm")
(install-symbolic-scheme-number-package)
(install-symbolic-real-number-package)
(install-symbolic-complex-package)
(load "2.complex-rectangular.scm")
(load "2.complex-polar.scm")
(install-complex-rectangular-package)
(install-complex-polar-package)
(load "2.79.symbolic-equ?.scm")
(load "2.80.symbolic-=zero?.scm")
(load "2.83.symbolic-raise.scm")
(load "2.85.symbolic-project.scm")
(load "2.85.symbolic-no-drop.scm")
(load "2.88.symbolic-negate.scm")
(load "2.88.polynomial-subtract.scm")
(load "2.91.polynomial-divide.scm")
(install-symbolic-equ?-package)
(install-symbolic-=zero?-package)
(install-symbolic-raise-package)
(install-symbolic-project-package)
(install-symbolic-no-drop-package)
(install-symbolic-negate-package)
(install-polynomial-subtract-package)
(install-symbolic-polynomial-divide-package)
(load "2.92.symbolic-polynomial.scm")
(install-symbolic-polynomial-package)
(load "2.90.termlist-sparse.scm")
(load "2.90.termlist-dense.scm")
(install-termlist-sparse-package)
(install-termlist-dense-package)
(load "2.93.symbolic-rational.scm")
(install-symbolic-rational-package)
;; Install packages
(load "2.apply-generic.scm") ; Revert
(load "2.94.symbolic-greatest-common-divisor-interface.scm")
(load "2.94.scheme-number-greatest-common-divisor.scm")
(install-scheme-number-greatest-common-divisor-package)
(load "2.94.polynomial-greatest-common-divisor.scm")
(install-polynomial-greatest-common-divisor-package)
;; Test
(define p1 (make-polynomial-from-sparse 'x '((4 1) (3 -1) (2 -2) (1 2))))
(define p2 (make-polynomial-from-sparse 'x '((3 1) (1 -1))))
(print (greatest-common-divisor p1 p2))
