(define (install-symbolic-polynomial-package)
  ;; internal procedures
  ;; representation of poly
  (include "2.polynomial-abstraction.scm") ; variable, term-list, make-poly
  ;; Variable
  (include "2.variable.scm") ; variable?, same-variable?
  ;; representation of terms and term lists
  (include "2.term.scm") ; order, coeff, make-term
  (include "2.90.termlist-abstraction.scm") ; (*)
  (include "2.termlist-interface.scm") ; add-terms, mul-terms
  ;; Proc
  (define (add-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
        (make-poly (variable p1)
                   (add-terms (term-list p1)
                              (term-list p2)))
        (error "Polys not in same var -- ADD-POLY"
               (list p1 p2))))
  (define (mul-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
        (make-poly (variable p1)
                   (mul-terms (term-list p1)
                              (term-list p2)))
        (error "Polys not in same var -- MUL-POLY"
               (list p1 p2))))
  ;; interface to rest of the system
  (define (tag p) (attach-tag 'polynomial p))
  (put 'add '(polynomial polynomial)
       (lambda (p1 p2) (tag (add-poly p1 p2))))
  (put 'mul '(polynomial polynomial)
       (lambda (p1 p2) (tag (mul-poly p1 p2))))
  (put '=zero? '(polynomial) ; (*)
       (lambda (p)
         (empty-termlist? (term-list p))))
  (put 'negate '(polynomial) ; (*)
       (lambda (p)
         (tag (make-poly (variable p)
                         (negate-terms (term-list p))))))
  (put 'make-from-sparse 'polynomial
       (lambda (var terms) (tag (make-poly var (make-from-sparse terms)))))
  (put 'make-from-dense 'polynomial
       (lambda (var terms) (tag (make-poly var (make-from-dense terms)))))
  'done)
;; Cons
(define (make-polynomial-from-sparse var terms) ; (*)
  ((get 'make-from-sparse 'polynomial) var terms))
(define (make-polynomial-from-dense var terms) ; (*)
  ((get 'make-from-dense 'polynomial) var terms))
;; Pred
(define (polynomial? n)
  (equal? (type-tag n) 'polynomial))
