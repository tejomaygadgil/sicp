;; Sel
(define (numer x) (car x))
(define (denom x) (cdr x))
;; Cons
(define (make-rat n d) ; 2.1.scm
  (let ((g (gcd n d)))
    (if (> d 0)
      (cons (/ n g) (/ d g))
      (cons (/ (* -1 n) g) (/ (* -1 d) g)))))
