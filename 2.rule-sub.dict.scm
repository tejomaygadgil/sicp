(define the-empty-dict '())

(define (extend-dict pat dat dict)
  (let ((vname (variable-name pat)))
    (let ((v (assq vname dict)))
      (let ((res
      (cond ((not v)
             (cons (list vname dat) dict))
            ((eq? (cadr v) dat) dict)
            (else 'failed))))
        res))))

(define (lookup var dict)
  (let ((v (assq var dict)))
    (if (not v) var
        (cadr v))))
