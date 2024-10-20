(define (install-termlist-sparse-package)
  (include "2.term.scm")
  ;; Sel
  (define (first-term term-list) (car term-list))
  (define (rest-terms term-list) (cdr term-list))
  ;; Pred
  (define (empty-termlist? term-list) (null? term-list))
  ;; Proc
  (define (adjoin-term term term-list)
    (if (=zero? (coeff term))
        term-list
        (cons term term-list)))
  (include "2.88.termlist-negate-terms.scm")
  ;; Install
  (define (tag p) (attach-tag 'sparse p))
  (put 'first-term '(sparse) first-term)
  (put 'rest-terms '(sparse)
       (lambda (x) (tag (rest-terms x))))
  (put 'empty-termlist? '(sparse) empty-termlist?)
  (put 'adjoin-term 'sparse
       (lambda (term term-list) (tag (adjoin-term term term-list))))
  (put 'negate-terms '(sparse)
       (lambda (term-list) (tag (negate-terms term-list))))
  (put 'make 'sparse
       (lambda (x) (tag x)))
  'done)
