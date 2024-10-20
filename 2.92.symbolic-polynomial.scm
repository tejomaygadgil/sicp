(define (install-symbolic-polynomial-package)
  ;; internal procedures
  ;; representation of poly
  (include "2.polynomial-abstraction.scm") ; variable, term-list, make-poly
  ;; Variable
  (include "2.variable.scm") ; variable?, same-variable?
  (include "2.92.variable-raise.scm") ; raise-var, greater?
  ;; representation of terms and term lists
  (include "2.term.scm") ; order, coeff, make-term
  (include "2.92.term-same-term?.scm") ; same-term?
  (include "2.90.termlist-abstraction.scm") ; Generic operations
  (include "2.termlist-interface.scm") ; add-terms, mul-terms
  (include "2.91.termlist-div-terms.scm") ; div-terms
  (include "2.92.termlist-same-termlist?.scm") ; same-termlist?
  ;; Proc
  (define (raise-poly p)
    (let ((new-variable (raise-var (variable p)))
          (new-termlist (make-from-sparse (list (make-term 0 (tag p))))))
      (make-poly new-variable new-termlist)))
  (define (apply-poly op p1 p2)
    (if (same-variable? (variable p1) (variable p2))
      (make-poly (variable p1)
                 (op (term-list p1)
                     (term-list p2)))
      (if (greater? (variable p1) (variable p2))
        (apply-poly op p1 (raise-poly p2))
        (apply-poly op (raise-poly p1) p2))))
  ;; interface to rest of the system
  (define (tag p) (attach-tag 'polynomial p))
  (put 'add '(polynomial polynomial)
       (lambda (p1 p2)
         (tag (apply-poly add-terms
                          p1 p2))))
  (put 'mul '(polynomial polynomial)
       (lambda (p1 p2)
         (tag (apply-poly mul-terms
                          p1 p2))))
  (put 'div '(polynomial polynomial)
       (lambda (p1 p2)
         (tag (apply-poly (lambda (p1 p2)
                            (quotient-terms p1 p2))
                          p1 p2))))
  (put 'div-terms '(polynomial polynomial) ; Convenience
       (lambda (p1 p2)
         (if (same-variable? (variable p1)
                             (variable p2))
           (div-terms (term-list p1)
                      (term-list p2))
        (error "Polys not in same var -- DIV-TERMS"))))
  (put 'project '(polynomial)
       (lambda (p)
         (coeff (first-term (term-list p)))))
  (put 'equ? '(polynomial polynomial)
       (lambda (p1 p2)
         (and (same-variable? (variable p1)
                              (variable p2))
              (same-termlist? (term-list p1)
                              (term-list p2)))))
  (put '=zero? '(polynomial)
       (lambda (x) (empty-termlist? (term-list x))))
  (put 'negate '(polynomial)
       (lambda (p)
         (tag (make-poly (variable p)
                         (negate-terms (term-list p))))))
  (put 'make-from-sparse 'polynomial
       (lambda (var terms)
         (tag (make-poly var
                         (make-from-sparse terms)))))
  (put 'make-from-dense 'polynomial
       (lambda (var terms)
         (tag (make-poly var
                         (make-from-dense terms)))))
  'done)
;; Cons
(define (make-polynomial-from-sparse var terms)
  ((get 'make-from-sparse 'polynomial) var terms))
(define (make-polynomial-from-dense var terms)
  ((get 'make-from-dense 'polynomial) var terms))
(define (div-terms p1 p2)
  (apply-generic 'div-terms p1 p2))
;; Pred
(define (polynomial? n)
  (equal? (type-tag n) 'polynomial))
