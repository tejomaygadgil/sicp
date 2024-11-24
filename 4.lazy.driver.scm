(define (user-print object)
  (if (compound-procedure? object)
    (display (list 'compound-procedure
                   (procedure-parameters object)
                   (procedure-body object)
                   '<procedure-env>))
    (display object)))
(define (driver-loop)
  (define input-prompt ";;; L-Eval input:")
  (define output-prompt ";;; L-Eval value:")
  (define (prompt-for-input string)
    (newline) (newline) (display string) (newline))
  (define (announce-output string)
    (newline) (display string) (newline))
  (prompt-for-input input-prompt)
  (let ((input (read)))
    (let ((output
            (actual-value input the-global-environment))) ; Changed
      (announce-output output-prompt)
      (user-print output)))
  (driver-loop))
