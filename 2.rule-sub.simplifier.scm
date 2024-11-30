(define (simplifier the-rules)
  (define (simplify-exp exp)
    (try-rules (if (compound? exp)
                   (map simplify-exp exp)
                   exp)))
  (define (try-rules exp)
    (let scan ((rules the-rules))
      (if (null? rules) exp
          (let ((dict (match (pattern (car rules))
                             exp
                             the-empty-dict)))
            (if (eq? dict 'failed)
                (scan (cdr rules))
                (simplify-exp
                  (instantiate (skeleton
                                 (car rules))
                               dict)))))))
  simplify-exp)
