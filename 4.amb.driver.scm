(define (driver-loop)
  (internal-loop
    (lambda ()
      (newline)
      (display ";;; There is no current problem")
      (driver-loop))))
(define (internal-loop try-again)
  (prompt-for-input input-prompt)
  (let ((input (read)))
    (if (eq? input 'try-again)
      (try-again)
      (begin
        (newline)
        (display ";;; Starting a new problem ")
        (newline)
        (ambeval input
                 the-global-environment
                 (lambda (val next-alternative)
                   (announce-output output-prompt)
                   (user-print val)
                   (internal-loop next-alternative))
                 (lambda ()
                   (announce-output ";;; There are no more values of")
                   (user-print input)
                   (driver-loop)))))))
(define (prompt-for-input string)
  (newline) (newline) (display string) (newline))
(define input-prompt ";;; Amb-Eval input:")
(define output-prompt ";;; Amb-Eval value:")
(define (announce-output string)
  (newline) (display string) (newline))
(define (user-print object)
  (if (compound-procedure? object)
    (display (list 'compound-procedure
                   (procedure-parameters object)
                   (procedure-body object)
                   '<procedure-env>))
    (display object)))
