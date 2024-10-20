(define (install-polynomial-greatest-common-divisor-package)
  ;; internal procedures
  ;; representation of poly
  (include "2.polynomial-abstraction.scm") ; variable, term-list, make-poly
  ;; Variable
  (include "2.variable.scm") ; variable?, same-variable?
  ;; representation of terms and term lists
  (include "2.term.scm") ; order, coeff, make-term
  (include "2.90.termlist-abstraction.scm") ; Generic operations
  (include "2.termlist-interface.scm") ; add-terms, mul-terms
  (include "2.91.termlist-div-terms.scm") ; div-terms
  (include "2.96.termlist-gcd-terms.scm") ; gcd-terms
  ;; Proc
  (define (gcd-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
      (make-poly (variable p1)
                 (gcd-terms (term-list p1)
                            (term-list p2)))
      (error "Polys not in same var -- GCD-POLY"
             (list p1 p2))))
  ;; Install
  (define (tag x) (attach-tag 'polynomial x))
  (put 'greatest-common-divisor '(polynomial polynomial)
       (lambda (x y)
         (tag (gcd-poly x y))))
  'done)
;; Interface
(define (greatest-common-divisor x y)
  (apply-generic 'greatest-common-divisor x y))
