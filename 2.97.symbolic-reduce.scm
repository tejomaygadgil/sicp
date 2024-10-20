(define (install-symbolic-reduce-package)
  ;; Install
  (define (tag-scheme-number x) (attach-tag 'scheme-number x))
  (define (tag-polynomial x) (attach-tag 'polynomial x))
  (put 'reduce '(scheme-number scheme-number)
       (lambda (n d)
         (let ((n (* n (if (> d 0) 1 -1)))
               (d (* d (if (> d 0) 1 -1)))
               (g (greatest-common-divisor n d)))
           (cons (tag-scheme-number (/ n g))
                 (tag-scheme-number (/ d g))))))
  (put 'reduce '(polynomial polynomial)
       (lambda (x y)
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
         (include "2.97.termlist-reduce-terms.scm") ; reduce-terms
         ;; Prod
         (define (reduce-poly p1 p2)
           (if (same-variable? (variable p1) (variable p2))
             (map (lambda (tl)
                    (make-poly (variable p1) tl))
                  (reduce-terms (term-list p1)
                                (term-list p2)))
             (error "Polys not in same var -- REDUCE-POLY"
                    (list p1 p2))))
         (let ((res (map tag-polynomial (reduce-poly x y))))
           (cons (car res) (cadr res))))) ; (*) Rational is expecting `cons`
  'done)
;; Interface
(define (reduce x y)
  (apply-generic 'reduce x y))
