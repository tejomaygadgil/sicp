;;;; 2.96
;; More precisely, if $P$ and $Q$ are polynomials, let $O_1$ be the order of $P$ (i.e., the order of the largest term of $P$) and let $O_2$ be the order of $Q$. Let $c$ be the leading coefficient of $Q$. Then it can be shown that, if we multiply $P$ by the integerizing factor $c^{1 + O_1 - O_2}$, the resulting polynomial can be divided by $Q$ by using the `div-terms` algorithm without introducing any fractions. The operation of multiplying the dividend by this constant and then dividing is sometimes called the pseudodivision of $P$ by $Q$. The remainder of the division is called the pseudoremainder.
;;
;; a. Implement the procedure `pseudoremainder-terms`, which is just like `remainder-terms` except that it multiplies the dividend by the integerizing factor described above before calling `div-terms.` Modify `gcd-terms` to use `pseudoremainder-terms`, and verify that `greatest-common-divisor` now produces an answer with integer coefficients on the example in exercise 2.95.
;;
;; b. The GCD now has integer coefficients, but they are larger than those of $P_1$. Modify `gcd-terms` so that it removes common factors from the coefficients of the answer by dividing all the coefficients by their (integer) greatest common divisor.

;;; Answer
(load "0.util.scm")
(load "0.table.scm")
(load "2.92.apply-generic.scm")
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
(load "2.94.symbolic-greatest-common-divisor-interface.scm")
(load "2.94.scheme-number-greatest-common-divisor.scm")
(install-scheme-number-greatest-common-divisor-package)
;; Install packages
(load "2.96.polynomial-greatest-common-divisor.scm")
(install-polynomial-greatest-common-divisor-package)
;; Test
(define p1 (make-polynomial-from-sparse 'x '((2 1) (1 -2) (0 1))))
(define p2 (make-polynomial-from-sparse 'x '((2 11) (0 7))))
(define p3 (make-polynomial-from-sparse 'x '((1 12) (0 5))))
(define q1 (mul p1 p2))
(define q2 (mul p1 p3))
(test (greatest-common-divisor q1 q2)
      (make-polynomial-from-sparse 'x '((2 1) (1 -2) (0 1))))
