;;;; 2.56
;; Extend the differentiation program to handle sums and products of arbitrary numbers of (two or more) terms. Then the last example above could be expressed as
;;
;; (deriv '(* x y (+ x 3)) 'x)
;;
;; Try to do this by changing only the representation for sums and products, without changing the `deriv` procedure at all. For example, the `addend` of a sum would be the first term, and the `augend` would be the sum of the rest of the terms.

;;; Answer
(load "2.56.scm")

;; Modify "rest" selector to handle case for >1 nargs
(define (augend s)
  (cond ((null? (cdddr s)) (caddr s))
        (else (append '(+) (cddr s)))))
(define (multiplicand p)
  (cond ((null? (cdddr p)) (caddr p))
        (else (append '(*) (cddr p)))))
;; Recursion with `deriv` transforms expressions into nested lists
;; e.g. (+ a b c d) -> (+ a (+ b (+ c (+ d))))

;; Test
(load "0.util.scm")
(test (deriv '(* x y (+ x 3)) 'x) '(+ (* x y) (* y (+ x 3))))
(test (deriv '(* x y z (+ x 3)) 'x) '(+ (* x (* y z)) (* y z (+ x 3))))
