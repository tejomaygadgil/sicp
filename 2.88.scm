;;;; 2.88
;; Extend the polynomial system to include subtraction of polynomials. (Hint: You may find it helpful to define a generic negation operation.

;;; Answer
;; We implement polynomial subtraction in a generic way as a composition
;; of negation and addition dispatching on type. This allows the subtraction
;; package to be re-used later on top of different procedural representations.
;;
;; Polynomial subtraction uses `negate`, which we define for all number types.
;; Polynomial negation is accomplished by defining a new `term-list` operation
;; called `negate-terms`, which recursively negates every coefficient - which
;; might itself be another polynomial!

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
(load "2.symbolic-polynomial-sparse.scm")
(install-symbolic-scheme-number-package)
(install-symbolic-rational-package)
(install-symbolic-real-number-package)
(install-symbolic-complex-package)
(install-symbolic-polynomial-sparse-package)
(load "2.complex-rectangular.scm")
(load "2.complex-polar.scm")
(install-complex-rectangular-package)
(install-complex-polar-package)
(load "2.79.symbolic-equ?.scm")
(load "2.80.symbolic-=zero?.scm")
(load "2.83.symbolic-raise.scm")
(load "2.85.symbolic-project.scm")
(load "2.85.symbolic-no-drop.scm")
(load "2.87.polynomial-=zero?.scm")
(install-symbolic-equ?-package)
(install-symbolic-=zero?-package)
(install-symbolic-raise-package)
(install-symbolic-project-package)
(install-symbolic-no-drop-package)
(install-polynomial-=zero?-package)
;; Install package
(load "2.88.symbolic-negate.scm")
(load "2.88.polynomial-subtract.scm")
(install-symbolic-negate-package)
(install-polynomial-subtract-package)
;; Test negate
(define z (make-rational 1 2))
(define y (make-polynomial 'x '((4 1) (2 1))))
(define x (make-polynomial 'x (list (list 4 z)
                                    (list 2 y))))
(define n (make-polynomial 'x (list (list 4 (negate z))
                                    (list 2 (negate y)))))
(test (negate x) n)
;; Test sub
(define x0 (make-polynomial 'x '()))
(define x1 (make-polynomial 'x '((2 1))))
(define x2 (make-polynomial 'x '((4 1))))
(define x3 (make-polynomial 'x (list (list 4 1)
                                     (list 2 (make-polynomial 'y '(3 1))))))
(test (sub x1 x1) (make-polynomial 'x '()))
(test (=zero? (sub x1 x1)) true)
(test (sub x2 x1) (make-polynomial 'x '((4 1) (2 -1))))
