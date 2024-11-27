(define (install-an-integer-between)
  (global-eval
    '(define (an-integer-between a b)
       (require (not (< b a)))
       (amb a (an-integer-between (+ a 1) b)))))
