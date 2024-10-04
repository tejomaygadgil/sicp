;;;; 2.73
;; Section 2.3.2 described a program that performs symbolic differentiation:
;;
;; (define (deriv exp var)
;;   (cond ((number? exp) 0)
;;         ((variable? exp) (if (same-variable? exp var) 1 0))
;;         ((sum? exp)
;;          (make-sum (deriv (addend exp) var)
;;                    (deriv (augend exp) var)))
;;         ((product? exp)
;;          (make-sum
;;            (make-product (multiplier exp)
;;                          (deriv (multiplicand exp) var))
;;            (make-product (deriv (multiplier exp) var)
;;                          (multiplicand exp))))
;;         <more rules can be added here>
;;         (else (error "unknown expression type -- DERIV" exp))))
;;
;; We can regard this program as performing a dispatch on the type of the expression to be differentiated. In this situation the "type tag" of the datum is the algebraic operator symbol (such as `+`) and the operation being performed is `deriv`. We can transform this program into data-directed style by rewriting the basic derivative procedure as

(define (deriv exp var)
   (cond ((number? exp) 0)
         ((variable? exp) (if (same-variable? exp var) 1 0))
         (else
           (let ((proc (get 'deriv (operator exp))))
             (if proc
               (proc (operands exp) var)
               (error "unknown expression type -- DERIV" exp var))))))

(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

;; a.  Explain what was done above. Why can't we assimilate the predicates `number?` and `same-variable?` into the data-directed dispatch?
;;
;; b.  Write the procedures for derivatives of sums and products, and the auxiliary code required to install them in the table used by the program above.
;;
;; c.  Choose any additional differentiation rule that you like, such as the one for exponents (exercise 2.56), and install it in this data-directed system.
;;
;; d.  In this simple algebraic manipulator the type of an expression is the algebraic operator that binds it together. Suppose, however, we indexed the procedures in the opposite way, so that the dispatch line in `deriv` looked like
;;
;; ((get *op-table* (operator exp) 'deriv) (operands exp) var)
;;
;; What corresponding changes to the derivative system are required?

;;; Answer
;; a. We refactor `deriv` from direct dispatch design using `cond` to data-directed dispatch using the `operator` selector. Scheme numbers and variables cannot partake because they don't follow the `exp` data abstraction.

;; b.
(load "2.data-directed.scm")

(define *op-table* (make-hash-table))

;; Pred
(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))
(define (=number? exp num)
  (and (number? exp) (= exp num)))
;; Proc
(define (make op operand1 operand2)
  (let ((proc (get 'make op)))
    (if proc
      (proc operand1 operand2)
      (error "unknown expression type -- MAKE" op operand1 operand2))))

(define (install-sum)
  ;; Sel
  (define (addend exp) (car exp))
  (define (augend exp) (cadr exp))
  ;; Proc
  (define (make-sum a1 a2)
    (cond ((=number? a1 0) a2)
          ((=number? a2 0) a1)
          ((and (number? a1) (number? a2)) (+ a1 a2))
          (else (list '+ a1 a2))))
  (define (deriv-sum exp var)
    (make '+ (deriv (addend exp) var)
             (deriv (augend exp) var)))
  ;; Install
  (put 'deriv '+ deriv-sum)
  (put 'make '+ make-sum)
  'done)

(define (install-product)
  ;; Sel
  (define (multiplier p) (car p))
  (define (multiplicand p) (cadr p))
  ;; Proc
  (define (make-product m1 m2)
    (cond ((or (=number? m1 0) (=number? m2 0)) 0)
          ((=number? m1 1) m2)
          ((=number? m2 1) m1)
          ((and (number? m1) (number? m2)) (* m1 m2))
          (else (list '* m1 m2))))
  (define (deriv-product exp var)
    (make '+ (make '* (multiplier exp)
                      (deriv (multiplicand exp) var))
             (make '* (deriv (multiplier exp) var)
                      (multiplicand exp))))
  ;; Install
  (put 'deriv '* deriv-product)
  (put 'make '* make-product)
  'done)

(install-sum)
(install-product)

;; c.  Choose any additional differentiation rule that you like, such as the one for exponents (exercise 2.56), and install it in this data-directed system.

(define (install-**)
  ;; Sel
  (define (base exp) (car exp))
  (define (exponent exp) (cadr exp))
  ;; Proc
  (define (make-exponent e1 e2)
    (cond ((=number? e2 0) 1)
          ((=number? e2 1) e1)
          ((and (number? e1) (number? e2)) (expt e1 e2))
          (else (list '** e1 e2))))
  (define (deriv-exponent expr var)
    (make '* (make '* (exponent expr)
                      (make '** (base expr)
                                (make '+ (exponent expr) -1)))
             (deriv (base expr) var)))
  ;; Install
  (put 'make '** make-exponent)
  (put 'deriv '** deriv-exponent)
  'done)

(install-**)

;; Test
(load "0.util.scm")
(test (deriv '0 'x) 0)
(test (deriv 'x 'x) 1)
(define e1 (make '+ 'x 'y))
(define e2 (make '* 'x 'y))
(define e3 (make '+ 'x 3))
(define e4 (make '* 3 'x))
(define e5 (make '** 'x 3))
(define e6 (make '** 'x e1))
(define b1 (make '+ 'x (make '** 'x 2)))
(define e7 (make '** b1 3))
(define e8 (make '** 'x (make '+ 'x 'y)))
(test (deriv e1 'x) 1)
(test (deriv e2 'x) 'y)
(test (deriv (make '+ e1 e2) 'x) (list '+ 1 'y))
(test (deriv (make '* e1 e2) 'x) (list '+ (list '* e1 'y) e2))
(test (deriv e5 'x) (list '* 3 (list '** 'x 2)))
(test (deriv e6 'x) (list '* e1 (list '** 'x (list '+ (list '+ 'x 'y) -1))))

;; d. We can accommodate the swapped `get` argument by swapping the arguments in all `put` statements.
