;; Sel
(define (lazy-pair? proc)
  (let ((body (procedure-body proc)))
    (if (null? (cdar body)) false
      (eq? (cadar body) 'lazy-pair))))
;; Proc
(define (lazy-display pair history)
  (define (print element history) ; Print until hitting
    (if (thunk? element) (display "...") ; a thunk
        (if (in-history? element history) (display "...") ; a previous element
            (user-print (thunk-value element) ; Mutual recursion
                        (cons element history)))))
  (define (iter pair)
    (let ((x (lookup-variable-value (caddar (procedure-body pair))
                                    (procedure-environment pair)))
          (y (lookup-variable-value (car (cdddar (procedure-body pair)))
                                    (procedure-environment pair))))
      (print x history) (display " ") (print y history)))
  (display "{") 
  (iter pair) 
  (display "}"))
