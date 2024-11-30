(define (apply-rules pattern frame)
  (display-line "Applying rules... ")
  (display pattern)
  (define (apply-a-rule rule query-pattern query-frame)
    (let ((clean-rule (rename-variables-in rule)))
      (let ((unify-result
             (unify-match query-pattern
                          (conclusion clean-rule)
                          query-frame)))
        (if (eq? unify-result 'failed)
            the-empty-stream
            (qeval (rule-body clean-rule)
                   (singleton-stream unify-result))))))
  (stream-flatmap
    (lambda (rule)
      (apply-a-rule rule pattern frame))
    (fetch-rules pattern frame)))
