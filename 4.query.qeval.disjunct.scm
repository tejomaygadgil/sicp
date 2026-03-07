(define (install-disjunct-package)
  (put 'or 'qeval disjoin)
  'ok)

(define (disjoin disjuncts frame-stream)
  (if (empty-disjunction? disjuncts)
      the-empty-stream
      (interleave-delayed
       (qeval (first-disjunct disjuncts) frame-stream)
       (delay (disjoin (rest-disjuncts disjuncts)
                       frame-stream)))))

(define (first-disjunct exps)
  (car exps))

(define (rest-disjuncts exps)
  (cdr exps))

(define (empty-disjunction? exps)
  (null? exps))
