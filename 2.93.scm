;;;; 2.93
;; Modify the rational-arithmetic package to use generic operations, but change `make-rat` so that it does not attempt to reduce fractions to lowest terms. Test your system by calling `make-rational` on two polynomials to produce a rational function
;;
;; (define p1 (make-polynomial 'x '((2 1)(0 1))))
;; (define p2 (make-polynomial 'x '((3 1)(0 1))))
;; (define rf (make-rational p2 p1))
;;
;; Now add `rf` to itself, using `add.` You will observe that this addition procedure does not reduce fractions to lowest terms.

;;; Answer
;; Our work across the next few exercises will parallel that of
;; generalizing complex numbers to hold symbolic data-types (2.86.scm).
;; A simple change in operators (this exercise) will require more complex
;; changes in the type-dispatching logic to handle the new representation.
;;
;; Here we revert to simple apply-logic from the text to skirt coercion
;; issues that will arise given that rationals can now hold polynomials.

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
;; Install packages
(load "2.apply-generic.scm") ; Revert
(load "2.93.symbolic-rational.scm")
(install-symbolic-rational-package)
;; Test
(define p1 (make-polynomial-from-sparse 'x '((2 1) (0 1))))
(define p2 (make-polynomial-from-sparse 'x '((3 1) (0 1))))
(define rf (make-rational p2 p1))
(print rf)
(print (add rf rf))
