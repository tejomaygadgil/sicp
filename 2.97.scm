;;;; 2.97
;; Thus, here is how to reduce a rational function to lowest terms:
;;
;; - Compute the GCD of the numerator and denominator, using the version of `gcd-terms` from exercise 2.96.
;; - When you obtain the GCD, multiply both numerator and denominator by the same integerizing factor before dividing through by the GCD, so that division by the GCD will not introduce any noninteger coefficients. As the factor you can use the leading coefficient of the GCD raised to the power $1 + O_1 - O_2$, where 4O_24 is the order of the GCD and $O_1$ is the maximum of the orders of the numerator and denominator. This will ensure that dividing the numerator and denominator by the GCD will not introduce any fractions.
;; - The result of this operation will be a numerator and denominator with integer coefficients. The coefficients will normally be very large because of all of the integerizing factors, so the last step is to remove the redundant factors by computing the (integer) greatest common divisor of all the coefficients of the numerator and the denominator and dividing through by this factor.
;;
;; a. Implement this algorithm as a procedure `reduce-terms` that takes two term lists `n` and `d` as arguments and returns a list `nn`, `dd`, which are `n` and `d` reduced to lowest terms via the algorithm given above. Also write a procedure `reduce-poly`, analogous to `add-poly`, that checks to see if the two polys have the same variable. If so, `reduce-poly` strips off the variable and passes the problem to `reduce-terms`, then reattaches the variable to the two term lists supplied by `reduce-terms`.
;;
;; b. Define a procedure analogous to `reduce-terms` that does what the original `make-rat` did for integers:
;;
;; (define (reduce-integers n d)
;;   (let ((g (gcd n d)))
;;     (list (/ n g) (/ d g))))
;;
;; and define `reduce` as a generic operation that calls `apply-generic` to dispatch to either `reduce-poly` (for polynomial arguments) or `reduce-integers` (for scheme-number arguments). You can now easily make the rational-arithmetic package reduce fractions to lowest terms by having `make-rat` call reduce before combining the given numerator and denominator to form a rational number. The system now handles rational expressions in either integers or polynomials. To test your program, try the example at the beginning of this extended exercise:
;;
;; (define p1 (make-polynomial 'x '((1 1)(0 1))))
;; (define p2 (make-polynomial 'x '((3 1)(0 -1))))
;; (define p3 (make-polynomial 'x '((1 1))))
;; (define p4 (make-polynomial 'x '((2 1)(0 -1))))
;;
;; (define rf1 (make-rational p1 p2))
;; (define rf2 (make-rational p3 p4))
;;
;; (add rf1 rf2)
;;
;; See if you get the correct answer, correctly reduced to lowest terms.

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
(load "2.94.symbolic-greatest-common-divisor-interface.scm")
(load "2.94.scheme-number-greatest-common-divisor.scm")
(install-scheme-number-greatest-common-divisor-package)
(load "2.96.polynomial-greatest-common-divisor.scm")
(install-polynomial-greatest-common-divisor-package)
;; Install packages
(load "2.97.symbolic-rational.scm")
(install-symbolic-rational-package)
(load "2.97.symbolic-reduce.scm")
(install-symbolic-reduce-package)
;; Test
(define p1 (make-polynomial-from-sparse 'x '((1 1) (0 1))))
(define p2 (make-polynomial-from-sparse 'x '((3 1) (0 -1))))
(define p3 (make-polynomial-from-sparse 'x '((1 1))))
(define p4 (make-polynomial-from-sparse 'x '((2 1) (0 -1))))
(define rf1 (make-rational p1 p2))
(define rf2 (make-rational p3 p4))
(print (add rf1 rf2))
