(define (install-disjunct-package)
  (put 'or 'qeval disjoin)
  'ok)

(define (disjoin disjuncts frame)
  (require (not (empty-disjunction? disjuncts)))
  (amb (qeval (first-disjunct disjuncts) frame)
       (disjoin (rest-disjuncts disjuncts)
                frame)))

(define (first-disjunct exps)
  (car exps))

(define (rest-disjuncts exps)
  (cdr exps))

(define (empty-disjunction? exps)
  (null? exps))
