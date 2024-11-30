;; Sel
(define (conclusion rule) (cadr rule))
(define (rule-body rule)
  (if (null? (cddr rule))
      '(always-true)
      (caddr rule)))
;; Pred
(define (rule? statement)
  (tagged-list? statement 'rule))
