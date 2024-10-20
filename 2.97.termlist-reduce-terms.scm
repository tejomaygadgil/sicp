(define (reduce-terms L1 L2)
  (let ((computed-gcd (gcd-terms L1 L2)))
    (let ((int-term (make-integerizing-term (coeff (first-term computed-gcd))
                                            (max (order (first-term L1))
                                                 (order (first-term L2)))
                                            (order (first-term computed-gcd)))))
      (let ((raw-terms (map (lambda (tl)
                              (quotient-terms (mul-term-by-all-terms int-term tl)
                                              computed-gcd))
                            (list L1 L2))))
        (let ((norm-term (make-normalizing-term (apply max (map gcd-termlist
                                                                raw-terms)))))
          (let ((reduced (map (lambda (tl) (mul-term-by-all-terms norm-term
                                                                  tl))
                              raw-terms)))
            (if (< (coeff (first-term (car reduced))) 0)
              (map negate-terms reduced)
              reduced)))))))
