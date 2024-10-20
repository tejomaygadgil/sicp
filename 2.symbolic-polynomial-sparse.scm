(define (install-symbolic-polynomial-sparse-package)
  ;; internal procedures
  ;; representation of poly
  (include "2.polynomial-abstraction.scm") ; variable, term-list, make-poly
  ;; Variable
  (include "2.variable.scm") ; variable?, same-variable?
  ;; representation of terms and term lists
  (include "2.term.scm") ; order, coeff, make-term
  (include "2.termlist-sparse.scm") ; first-term, rest-terms, empty-termlist?, adjoin-term, the-empty-termlist
  (include "2.termlist-interface.scm") ; add-terms, mul-terms , mul-term-by-all-terms
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
  (put 'make 'polynomial
       (lambda (var terms) (tag (make-poly var terms))))
  'done)
;; Cons
(define (make-polynomial var terms)
  ((get 'make 'polynomial) var terms))
;; Pred
(define (polynomial? n)
  (equal? (type-tag n) 'polynomial))
