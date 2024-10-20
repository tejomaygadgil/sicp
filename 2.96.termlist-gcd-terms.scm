(define (make-integerizing-term c o1 o2)
  (make-term 0
             (expt c
                   (+ 1 (- o1 o2)))))
(define (pseudoremainder-terms L1 L2)
  (remainder-terms
    (mul-term-by-all-terms
      (make-integerizing-term (coeff (first-term L2))
                              (order (first-term L1))
                              (order (first-term L2)))
      L1)
    L2))
(define (gcd-termlist term-list)
  (let tl-gcd ((tl term-list)
               (acc 0))
    (cond ((empty-termlist? tl) acc)
          (else (tl-gcd (rest-terms tl)
                        (gcd (coeff (first-term tl))
                             acc))))))
(define (make-normalizing-term factor)
  (make-term 0
             (/ 1 factor)))
(define (gcd-terms L1 L2)
  (if (empty-termlist? L2)
    (mul-term-by-all-terms (make-normalizing-term (gcd-termlist L1))
                           L1)
    (gcd-terms L2 (pseudoremainder-terms L1 L2))))
