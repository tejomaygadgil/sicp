(define input-prompt ";;; L-Eval input:")
(define output-prompt ";;; L-Eval value:")

(define (driver-loop)
  (prompt-for-input input-prompt)
  (let ((input (read)))
    (if (eq? input 'stop) 'ok
        (let ((output
               (actual-value input the-global-environment)))
          (announce-output output-prompt)
          (user-print output)
          (driver-loop)))))
