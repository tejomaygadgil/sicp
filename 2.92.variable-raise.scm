;; Obj
(define hierarchy '(v z y x))
;; Proc
(define (raise-var var)
  (let iter ((vars hierarchy))
    (if (null? vars)
      (error "Unregistered polynomial variable -- RAISE-VAR" var)
      (let ((first (car vars))
            (rest (cdr vars)))
        (if (same-variable? var first)
          (if (null? rest)
            'end-of-tower
            (car rest))
          (iter rest))))))
;; Pred
(define (greater? v1 v2)
  (if (same-variable? v1 v2) false
    (let iter ((v1 v1)
               (v2 v2))
      (cond ((same-variable? v1 v2) true)
            ((equal? v2 'end-of-tower) false)
            (else (iter v1 (raise-var v2)))))))
