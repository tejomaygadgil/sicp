(define (install-conjoin-package)
  ;; Sel
  (define (first-conjunct exps) (car exps))
  (define (rest-conjuncts exps) (cdr exps))
  ;; Pred
  (define (empty-conjunction? exps) (null? exps))
  ;; Proc
  (define (conjoin conjuncts frame-stream)
    (if (empty-conjunction? conjuncts)
        frame-stream
        (conjoin (rest-conjuncts conjuncts)
                 (qeval (first-conjunct conjuncts)
                        frame-stream))))
  ;; Install
  (put 'and 'qeval conjoin)
  'ok)
