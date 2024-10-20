;;;; 2.95
;; Define $P_1$, $P_2$, and $P_3$ to be the polynomials
;;
;; $$ P_1: r^2 - 2r + 1 $$
;; $$ P_2: 11r^2 + 7 $$
;; $$ P_3: 13r + 5 $$
;;
;; Now define $Q_1$ to be the product of $P_1$ and $P_2$ and $Q_2$ to be the product of $P_1$ and $P_3$, and use `greatest-common-divisor` (exercise 2.94) to compute the GCD of $Q_1$ and $Q_2$. Note that the answer is not the same as $P_1$. This example introduces noninteger operations into the computation, causing difficulties with the GCD algorithm. To understand what is happening, try tracing `gcd-terms` while computing the GCD or try performing the division by hand.

;;; Answer
;; `gcd-terms` does not properly reduce coefficients to their mutual GCD.
;; `(polynomial x sparse (2 1283/144) (1 -1283/72) (0 1283/144))` can be
;; further simplified by dividing all coefficients by GCD $1283/144$,
;; reducing `(greatest-common-denominator q1 q2)` to `p1` as expected.
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
(define p1 (make-polynomial-from-sparse 'x '((2 1) (1 -2) (0 1))))
(define p2 (make-polynomial-from-sparse 'x '((2 11) (0 7))))
(define p3 (make-polynomial-from-sparse 'x '((1 12) (0 5))))
(define q1 (mul p1 p2))
(define q2 (mul p1 p3))
(print (greatest-common-divisor q1 q2))
