(define input-prompt ";;; Query input:")
(define output-prompt ";;; Query results:")
(define (prompt-for-input string)
  (newline) (newline) (display string) (newline))
(define (query-driver-loop)
  (prompt-for-input input-prompt)
  (process-query (read))
  (query-driver-loop))
(define (process-query query)
  (define (assertion-to-be-added? exp)
    (eq? (type exp) 'assert!))
  (define (add-assertion-body exp)
    (car (contents exp)))
  (reset-hist!) ; Added
  (let ((q (query-syntax-process query)))
    (cond ((assertion-to-be-added? q)
           (add-rule-or-assertion! (add-assertion-body q))
           (newline)
           (display "Assertion added to data base."))
          (else
           (newline)
           (display output-prompt)
           (display-stream
            (stream-map
             (lambda (frame)
               (instantiate q
                            frame
                            (lambda (v f)
                              (contract-question-mark v))))
             (qeval q the-empty-frame-stream)))))))
