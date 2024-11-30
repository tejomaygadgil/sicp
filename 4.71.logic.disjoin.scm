(define (install-disjoin-package)
  ;; Sel
  (define (first-disjunct exps) (car exps))
  (define (rest-disjuncts exps) (cdr exps))
  ;; Pred
  (define (empty-disjunction? exps) (null? exps))
  ;; Proc
  (define (disjoin disjuncts frame-stream)
    (if (empty-disjunction? disjuncts)
        the-empty-stream
        (interleave
         (qeval (first-disjunct disjuncts) frame-stream)
         (disjoin (rest-disjuncts disjuncts) frame-stream))))
  ;; Install
  (put 'or 'qeval disjoin)
  'ok)
