;;;; 2.92
;; By imposing an ordering on variables, extend the polynomial package so that addition and multiplication of polynomials works for polynomials in different variables. (This is not easy!)

;;; Answer
;; We can impoase a variable ordering by installing a variable hierarchy within
;; `polynomial` and modifying the symbolic arithmetic hierarchy to coerce any
;; data type to-and-from polynomial. This change results in natural simplification
;; within polynomials, and across data types:
;;
;; ]=> (sub '(polynomial sparse x ((2 1) (0 3)))
;;           (polynomial sparse y ((2 1))))
;; ;Value: (polynomial x sparse (5 1)
;;                              (0 (polynomial y sparse (2 1))))
;;
;; ]=> (sub '(polynomial sparse x ((2 1) (0 3)))
;;           (polynomial sparse x ((2 1))))
;; ;Value: 3
;;
;; - 2.92.apply-generic.scm: Automatically coerce to numbers to polynomial and back
;; - 2.92.variable-raise.scm: Install variable hierarchy and `greater?` predicate
;; - 2.92.symbolic-polynomial.scm:
;;   - Consolidate addition, multiplication, and division
;;   - Install project, equ?
;; - 2.92.term-same-term?.scm: same-term? interface
;; - 2.92.termlist-same-termlist?.scm: same-termlist? interface

;; Test
(load "0.util.scm")
(load "0.table.scm")
(load "2.85.symbolic-tagged-data.scm")
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
(load "2.90.termlist-sparse.scm")
(load "2.90.termlist-dense.scm")
(install-termlist-sparse-package)
(install-termlist-dense-package)
;; Install packages
(load "2.92.apply-generic.scm")
(load "2.92.symbolic-polynomial.scm")
(install-symbolic-polynomial-package)
;; Test
(define p1 (make-polynomial-from-sparse 'x '((5 1) (0 -1))))
(define p2 (make-polynomial-from-sparse 'x '((2 1) (0 -1))))
(define p3 (make-polynomial-from-sparse 'y '((1 1))))
(print (add p1 p2))
(print (sub p1 p2))
(print (mul p1 p2))
(print (div p1 p2))
(print (add p1 p3))
(print (add (mul p1 p3) p2))
(print (mul p1 3.8))
