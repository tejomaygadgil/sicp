(define (driver-loop)
  (prompt-for-input input-prompt)
  (let ((input (read)))
    (if (eq? input 'stop) 'ok
        (let ((output
               (actual-value input the-global-environment)))
          (announce-output output-prompt)
          (user-print output the-empty-history))) ;; Changed
    (driver-loop)))

(define (user-print object history)
  (if (compound-procedure? object)
      (if (lazy-pair? object) ;; Changed
          (lazy-display object history)
          (display (list 'compound-procedure
                         (procedure-parameters object)
                         (procedure-body object)
                         '<procedure-env>)))
      (display object)))

(define (lazy-display pair history)
  (let ((lazy-print
         (lambda (element history) ;; Stop if
           (if (thunk? element)
               (display "...") ;; (1) Thunk
               (if (in-history? element history)
                   (display "...") ;; (2) Previous element
                   (user-print (thunk-value element) ;; Otherwise recurse
                               (cons element history))))))
        (head
         (lookup-variable-value
          (caddar (procedure-body pair))
          (procedure-environment pair)))
        (tail
         (lookup-variable-value
          (car (cdddar (procedure-body pair)))
          (procedure-environment pair))))
    (display "{")
    (lazy-print head history)
    (display " ")
    (lazy-print tail history)
    (display "}")))

(define (lazy-pair? proc)
  (let ((body (procedure-body proc)))
    (if (null? (cdar body)) false
        (eq? (cadar body) 'lazy-pair))))

(define the-empty-history '())

(define (in-history? element history)
  (if (null? history) false
      (if (equal? element (car history)) true
          (in-history? element (cdr history)))))
