(define (match pat exp dict)
  (cond ((eq? dict 'failed) 'failed)
        ((atom? pat)
         (if (atom? exp)
             (if (eq? pat exp)
                 dict
                 'failed)
             'failed))
        ((arbitrary-constant? pat)
         (if (constant? exp)
             (extend-dict pat exp dict)
             'failed))
        ((arbitrary-variable? pat)
         (if (variable? exp)
             (extend-dict pat exp dict)
            'failed))
        ((arbitrary-expression? pat)
         (extend-dict pat exp dict))
        ((atom? exp) 'failed)
        (else
          (match (cdr pat)
                 (cdr exp)
                 (match (car pat) ; Cool
                        (car exp)
                        dict)))))
