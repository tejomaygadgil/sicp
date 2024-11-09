;;;; 3.37
;; The `celsius-fahrenheit-converter` procedure is cumbersome when compared with a more expression-oriented style of definition, such as
;;
;; (define (celsius-fahrenheit-converter x)
;;   (c+ (c* (c/ (cv 9) (cv 5))
;;           x)
;;       (cv 32)))
;; (define C (make-connector))
;; (define F (celsius-fahrenheit-converter C))
;;
;; Here `c+`, `c*`, etc. are the "constraint" versions of the arithmetic operations. For example, `c+` takes two connectors as arguments and returns a connector that is related to these by an adder constraint:
;;
;; (define (c+ x y)
;;   (let ((z (make-connector)))
;;     (adder x y z)
;;     z))
;;
;; Define analogous procedures `c-`, `c*`, `c/`, and `cv` (constant value) that enable us to define compound constraints as in the converter example above.

;; Test
(load "0.util.scm")
(load "3.constraint.scm")
(load "3.37.constraint.expression.scm")
(define (celsius-fahrenheit-converter x)
  (c+ (c* (c/ (cv 9) (cv 5))
          x)
      (cv 32)))
(define F (make-connector))
(define C (celsius-fahrenheit-converter F))
(probe "F" F)
(probe "C" C)
(set-value! f 100 'user)
(newline)
(test (get-value C) 212)
