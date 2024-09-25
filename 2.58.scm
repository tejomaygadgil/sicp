;;;; 2.56
;; Suppose we want to modify the differentiation program so that it works with ordinary mathematical notation, in which `+` and `*` are infix rather than prefix operators. Since the differentiation program is defined in terms of abstract data, we can modify it to work with different representations of expressions solely by changing the predicates, selectors, and constructors that define the representation of the algebraic expressions on which the differentiator is to operate.
;;
;; a. Show how to do this in order to differentiate algebraic expressions presented in infix form, such as `(x + (3 * (x + (y + 2))))`. To simplify the task, assume that `+` and `*` always take two arguments and that expressions are fully parenthesized.
;;
;; b. The problem becomes substantially harder if we allow standard algebraic notation, such as `(x + 3 * (x + y + 2))`, which drops unnecessary parentheses and assumes that multiplication is done before addition. Can you design appropriate predicates, selectors, and constructors for this notation such that our derivative program still works?

;;; Answer
(load "2.56.scm")

;; a.
;; Pred
(define (sum? x)
  (and (pair? x) (eq? (cadr x) '+)))
(define (product? x)
  (and (pair? x) (eq? (cadr x) '*)))
;; Sel
(define (addend s) (car s))
(define (augend s) (caddr s))
(define (multiplier p) (car p))
(define (multiplicand p) (caddr p))
;; Cons
(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list a1 '+ a2))))
(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list m1 '* m2))))

;; Test
(load "0.util.scm")
(test (deriv '(x + (3 * (x * (y + 2)))) 'x) '(1 + (3 * (y + 2))))

;; b.
(load "0.util.scm")
;; Pred
(define (sum? x)
  (and (pair? x)
       (any (lambda (x) (eq? x '+)) x)))
(define (product? x)
  (and (pair? x)
       (not (sum? x)) ; Handle product last (to evaluate first)
       (any (lambda (x) (eq? x '*)) x)))
;; Sel
(define (keep-until expr sym)
  (let iter ((expr expr) (acc '()))
    (if (eq? (car expr) sym)
      (if (null? (cdr acc)) (car acc) acc)
      (iter (cdr expr) (append acc (list (car expr)))))))
(define (keep-after expr sym)
  (let iter ((expr expr))
    (if (eq? (car expr) sym)
      (if (null? (cddr expr)) (cadr expr) (cdr expr))
      (iter (cdr expr)))))
(define (addend s) (keep-until s '+))
(define (augend s) (keep-after s '+))
(define (multiplier s) (keep-until s '*))
(define (multiplicand s) (keep-after s '*))

;; Test
(define expr '(x + 3 * (x + y + 2)))
(test (deriv expr 'x) 4)
