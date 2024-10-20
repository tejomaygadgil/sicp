(define (install-symbolic-polynomial-divide-package)
  ;; internal procedures
  ;; representation of poly
  (include "2.polynomial-abstraction.scm") ; variable, term-list, make-poly
  ;; Variable
  (include "2.variable.scm") ; variable?, same-variable?
  ;; representation of terms and term lists
  (include "2.term.scm") ; order, coeff, make-term
  (include "2.90.termlist-abstraction.scm") ; Generic operations
  (include "2.91.termlist-div-terms.scm") ; div-terms
  (include "2.termlist-interface.scm") ; add-terms, mul-terms
  ;; Proc
  (define (div-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
        (make-poly (variable p1)
                   (quotient-terms (term-list p1)
                                   (term-list p2)))
        (error "Polys not in same var -- DIV-POLY"
               (list p1 p2))))
  ;; Install
  (define (tag p) (attach-tag 'polynomial p))
  (put 'div '(polynomial polynomial)
       (lambda (p1 p2) (tag (div-poly p1 p2))))
  'done)
