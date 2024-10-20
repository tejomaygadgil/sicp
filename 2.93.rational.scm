;; Sel
(define (numer x) (car x))
(define (denom x) (cdr x))
;; Cons
(define (make-rat n d) ; Explicit dispatching
  (cond ((and (scheme-number? n)
              (scheme-number? d))
         (let ((g (gcd n d)))
           (if (> d 0)
             (cons (/ n g) (/ d g))
             (cons (/ (* -1 n) g) (/ (* -1 d) g)))))
        ((and (polynomial? n)
              (polynomial? d))
         (cons n d))
        (else (error "Bad types -- MAKE-RAT" n d))))
