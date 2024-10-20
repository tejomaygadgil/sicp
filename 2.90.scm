;;;; 2.90
;; Suppose we want to have a polynomial system that is efficient for both sparse and dense polynomials. One way to do this is to allow both kinds of term-list representations in our system. The situation is analogous to the complex-number example of section 2.4, where we allowed both rectangular and polar representations. To do this we must distinguish different types of term lists and make the operations on term lists generic. Redesign the polynomial system to implement this generalization. This is a major effort, not a local change.

;;; Answer
;; Unlike complex numbers, polynomials are composed of multiple data abstractions.
;; `make-poly` is defined in terms of variables, terms, and term-lists. We only
;; modify the term-list representation. Everything else stays the same. Hence
;; the analogy between the two data types.
;;
;; Changelist
;; - 2.90.termlist-abstraction.scm: Replace data abstraction with generic procedures
;;   - n.b. `the-empty-termlist` returns a *sparse* term-list. Given interchangeable
;;           data representations, it's not clear we are even choosing anything here
;;           (cf. Leibniz's Principle of Indiscernability).
;; - 2.90.symbolic-polynomial.scm:
;;   - Replace term-list abstraction with data-directed version (*)
;;   - Re-install `=zero?`
;;   - Re-install `negate` (n.b. shadows 2.88.symbolic-negate.scm!)
;;   - Add type dispatching constructor
;; - Point polynomial negation to dispatching `negate-terms` (2.90.symbolic-negate.scm)

;; Test
(load "0.util.scm")
(load "0.table.scm")
(load "2.85.symbolic-tagged-data.scm")
(load "2.85.apply-generic.scm")
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
;; Op
(load "2.79.symbolic-equ?.scm")
(load "2.80.symbolic-=zero?.scm")
(load "2.83.symbolic-raise.scm")
(load "2.85.symbolic-project.scm")
(load "2.85.symbolic-no-drop.scm")
(load "2.88.symbolic-negate.scm")
(load "2.88.polynomial-subtract.scm")
(install-symbolic-equ?-package)
(install-symbolic-=zero?-package)
(install-symbolic-raise-package)
(install-symbolic-project-package)
(install-symbolic-no-drop-package)
(install-symbolic-negate-package)
(install-polynomial-subtract-package)
;; Install package
(load "2.90.symbolic-polynomial.scm")
(install-symbolic-polynomial-package)
(load "2.90.termlist-sparse.scm")
(load "2.90.termlist-dense.scm")
(install-termlist-sparse-package)
(install-termlist-dense-package)
;; Test
(define w (make-polynomial-from-dense 'x '(9)))
(define x (make-polynomial-from-dense 'x '(9 8 7 6 5)))
(define y (make-polynomial-from-sparse 'x '((4 9) (3 8) (2 7) (1 6) (0 5))))
(print (add x x))
(print (add x y))
(print (mul x x))
(print (mul x y))
(print (sub x y))
(print (sub y x))
