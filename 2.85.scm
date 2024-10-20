;;;; 2.85
;; This section mentioned a method for "simplifying" a data object by lowering it in the tower of types as far as possible. Design a procedure `drop` that accomplishes this for the tower described in exercise 2.83. The key is to decide, in some general way, whether an object can be lowered. For example, the complex number $1.5 + 0i$ can be lowered as far as `real`, the complex number $1 + 0i$ can be lowered as far as `integer`, and the complex number $2 + 3i$ cannot be lowered at all. Here is a plan for determining whether an object can be lowered: Begin by defining a generic operation `project` that "pushes" an object down in the tower. For example, projecting a complex number would involve throwing away the imaginary part. Then a number can be dropped if, when we `project` it and `raise` the result back to the type we started with, we end up with something equal to what we started with. Show how to implement this idea in detail, by writing a `drop` procedure that drops an object as far as possible. You will need to design the various projection operations and install `project` as a generic operation in the system. You will also need to make use of a generic equality predicate, such as described in exercise 2.79. Finally, use `drop` to rewrite `apply-generic` from exercise 2.84 so that it "simplifies" its answers.

;;; Answer
;; Our reliance on `apply-generic` for both normal dispatching and the "smart"
;; hierarchical coercion of the symbolic algebra system places the the abstract
;; procedure at risk of overload, introducing instability via infinite looping -
;;
;; Normal dispatch: equ?, =zero?, project, raise, real-part, imag-part, magnitude, angle
;; Smart dispatch: add, sub, mul, div
;;
;; We solve with the following changes denoted by (*)
;; (1) 2.85.symbolic-no-drop.scm - Install `no-drop` predicate to avoid simultaneous `raise` and `drop`
;; (2) 2.85.apply-generic.scm - `drop` falls back to identity map when `arg` is not projectable
;; (3) 2.85.symbolic-tagged-data.scm - Relax `type-tag` to return `not-found` instead of erroring out
;;
;; `no-drop` restricts `drop` to smart dispatch operations without having to
;; explicitly specify them, staying with the abstracted design of the system.

;; Test
(load "0.util.scm")
(load "0.table.scm")
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
(load "2.79.symbolic-equ?.scm")
(load "2.80.symbolic-=zero?.scm")
(load "2.83.symbolic-raise.scm")
(install-symbolic-equ?-package)
(install-symbolic-=zero?-package)
(install-symbolic-raise-package)
;; Install package
(load "2.85.apply-generic.scm")
(load "2.85.symbolic-project.scm")
(load "2.85.symbolic-no-drop.scm")
(install-symbolic-project-package)
(install-symbolic-no-drop-package)
;; Test
(test (add 5 (make-rational 5 6)) (make-rational 35 6))
(test (add (make-rational 5 6) 5) (make-rational 35 6))
(test (mul (make-rational 15 6) 0.4) 1)
(test (mul 0.4 (make-rational 15 6)) 1)
(test (add (make-rational 4 3) (make-rational 2 3)) 2)
