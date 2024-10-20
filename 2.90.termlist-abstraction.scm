;; Sel
(define (first-term term-list)
  (apply-generic 'first-term term-list))
(define (rest-terms term-list)
  (apply-generic 'rest-terms term-list))
;; Pred
(define (empty-termlist? term-list)
  (apply-generic 'empty-termlist? term-list))
;; Proc
(define (adjoin-term term term-list)
  ((get 'adjoin-term (type-tag term-list)) term
                                           (contents term-list)))
(define (negate-terms term-list)
  (apply-generic 'negate-terms term-list))
;; Obj
(define (the-empty-termlist)
  (make-from-sparse '())) ; (*)
;; Cons
(define (make-from-sparse terms)
  ((get 'make 'sparse) terms))
(define (make-from-dense terms)
  ((get 'make 'dense) terms))
