(define (install-conjoin-package)
  (put 'and 'qeval conjoin)
  'ok)

(define (conjoin conjuncts frame-stream)
  (if (empty-conjunction? conjuncts)
      frame-stream
      (conjoin (rest-conjuncts conjuncts)
               (qeval (first-conjunct conjuncts)
                      frame-stream))))

(define (first-conjunct exps)
  (car exps))

(define (rest-conjuncts exps)
  (cdr exps))

(define (empty-conjunction? exps)
  (null? exps))
