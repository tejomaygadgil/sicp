;; Inherit
(load "4.query.scm")
;; Modify
(define (apply-a-rule rule query-pattern query-frame)
  (let ((clean-rule (rename-variables-in rule)))
    (let ((unify-result
           (unify-match query-pattern
                        (conclusion clean-rule)
                        query-frame)))
      (if (eq? unify-result 'failed)
          the-empty-stream
          (let* ((lookup-value
                  (lambda (exp) (if (var? exp)
                                    (let ((binding (binding-in-frame exp query-frame)))
                                      (if binding
                                          (binding-value binding)
                                          binding))
                                    exp)))
                 (elem (map lookup-value query-pattern)))
            (if (> tries tries-depth)
                (begin (announce-output "Found loop")
                       the-empty-stream)
                (begin
                  (if (member elem history)
                      (set! tries (1+ tries))
                      (set! history (cons elem history)))
                  (qeval (rule-body clean-rule)
                         (singleton-stream unify-result)))))))))
(define (query-driver-loop)
  (set! tries 0)
  (prompt-for-input input-prompt)
  (mc-eval (read))
  (query-driver-loop))
;; Setup
(define history '())
(define tries 0)
(define tries-depth 10)
