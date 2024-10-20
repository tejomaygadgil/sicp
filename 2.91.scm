;;;; 2.91
;; A univariate polynomial can be divided by another one to produce a polynomial quotient and a polynomial remainder. For example,
;;
;; $$ \frac{x^5 - 1}{x^2 - 1} = x^3 + x, \text{ remainder } x - 1 $$
;;
;; Division can be performed via long division. That is, divide the highest-order term of the dividend by the highest-order term of the divisor. The result is the first term of the quotient. Next, multiply the result by the divisor, subtract that from the dividend, and produce the rest of the answer by recursively dividing the difference by the divisor. Stop when the order of the divisor exceeds the order of the dividend and declare the dividend to be the remainder. Also, if the dividend ever becomes zero, return zero as both quotient and remainder.
;;
;; We can design a `div-poly` procedure on the model of `add-poly` and `mul-poly`. The procedure checks to see if the two polys have the same variable. If so, `div-poly` strips off the variable and passes the problem to `div-terms`, which performs the division operation on term lists. `Div-poly` finally reattaches the variable to the result supplied by `div-terms`. It is convenient to design `div-terms` to compute both the quotient and the remainder of a division. `Div-terms` can take two term lists as arguments and return a list of the quotient term list and the remainder term list.
;;
;; Complete the following definition of `div-terms` by filling in the missing expressions. Use this to implement `div-poly`, which takes two polys as arguments and returns a list of the quotient and remainder polys.
;;
;; (define (div-terms L1 L2)
;;   (if (empty-termlist? L1)
;;       (list (the-empty-termlist) (the-empty-termlist))
;;       (let ((t1 (first-term L1))
;;             (t2 (first-term L2)))
;;         (if (> (order t2) (order t1))
;;             (list (the-empty-termlist) L1)
;;             (let ((new-c (div (coeff t1) (coeff t2)))
;;                   (new-o (- (order t1) (order t2))))
;;               (let ((rest-of-result
;;                      <compute rest of result recursively>
;;                      ))
;;                 <form complete result>
;;                 ))))))

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
(load "2.90.symbolic-polynomial.scm")
(install-symbolic-polynomial-package)
(load "2.90.termlist-sparse.scm")
(load "2.90.termlist-dense.scm")
(install-termlist-sparse-package)
(install-termlist-dense-package)
;; Install package
(load "2.91.polynomial-divide.scm")
(install-symbolic-polynomial-divide-package)
;; Test
(define p1 (make-polynomial-from-sparse 'x '((5 1) (0 -1))))
(define p2 (make-polynomial-from-sparse 'x '((2 1) (0 -1))))
(test (div p1 p2) (make-polynomial-from-sparse 'x '((3 1) (1 1))))
