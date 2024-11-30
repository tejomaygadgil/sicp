(define scheme-rules
  '(( (square (?c n)) (: (* n n)) )
    ( (fact 0) 1 )
    ( (fact (?c n)) (* (: n) (fact (: (- n 1)))) )
    ( (fib 0) 0 )
    ( (fib 1) 1 )
    ( (fib (?c n)) (+ (fib (: (- n 1)))
                      (fib (: (- n 2)))) )
    ( ((? op) (?c e1) (?c e2)) (: (op e1 e2)) ) ))
