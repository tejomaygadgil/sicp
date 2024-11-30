(define (apply-rules pattern frame)
  (define (loop-detected pattern) ; Added
    the-empty-stream)
  (define (apply-a-rule rule query-pattern query-frame)
    (let ((clean-rule (rename-variables-in rule)))
      (let ((unify-result
             (unify-match query-pattern
                          (conclusion clean-rule)
                          query-frame)))
        (if (eq? unify-result 'failed)
            the-empty-stream
            (let ((sig (make-sig query-pattern query-frame))) ; Added
              (if (and (in-hist? sig)
                       (out-of-tries?))
                  (loop-detected query-pattern)
                  (begin
                    (if (in-hist? sig)
                        (add-to-tries!)
                        (add-to-hist! sig))
                    (qeval (rule-body clean-rule)
                           (singleton-stream unify-result)))))))))
  (stream-flatmap
    (lambda (rule)
      (apply-a-rule rule pattern frame))
    (fetch-rules pattern frame)))
