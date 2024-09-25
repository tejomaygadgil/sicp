;;;; 2.56
;; Show how to extend the basic differentiator to handle more kinds of expressions. For instance, implement the differentiation rule
;;
;; \frac{d(u^n)}{dr} = n u^{n-1} \left( \frac{du}{dr} \right)
;;
;; by adding a new clause to the `deriv` program and defining appropriate procedures `exponentiation?`, `base`, `exponent`, and `make-exponentiation`. (You may use the symbol `**` to denote exponentiation.) Build in the rules that anything raised to the power 0 is 1 and anything raised to the power 1 is the thing itself.

;; Pred
(define (variable? x)
  (symbol? x))
(define (sum? x)
  (and (pair? x) (eq? (car x) '+)))
(define (product? x)
  (and (pair? x) (eq? (car x) '*)))
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))
(define (=number? exp num)
  (and (number? exp) (= exp num)))
;; Sel
(define (addend s) (cadr s))
(define (augend s) (caddr s))
(define (multiplier p) (cadr p))
(define (multiplicand p) (caddr p))
;; Cons
(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list '+ a1 a2))))
(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list '* m1 m2))))

;;; Answer
;; Pred
(define (exponent? x) (and (pair? x) (eq? (car x) '**)))
;; Sel
(define (base e) (cadr e))
(define (exponent e) (caddr e))
;; Cons
(define (make-exponent e1 e2)
  (cond ((=number? e2 0) 1)
        ((=number? e2 1) e1)
        ((and (number? e1) (number? e2)) (expt e1 e2))
        (else (list '** e1 e2))))
;; Proc
(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
           (make-product (multiplier exp)
                         (deriv (multiplicand exp) var))
           (make-product (deriv (multiplier exp) var)
                         (multiplicand exp))))
        ((exponent? exp)
         (let ((b (base exp))
               (e (exponent exp)))
           (make-product
             (make-product e
                           (make-exponent b
                                          (make-sum e -1)))
             (deriv b var))))
        (else
          (error "unknown expression type -- DERIV" exp))))

;; Some notes on implementation:
;; * `make-sum/product` do not simplify: (`(+ (+ a b) (+ c d))` =/=> `(+ a b c d)`)
;; * No interaction between `+` and `*`
;; * No interaction with `**` either
