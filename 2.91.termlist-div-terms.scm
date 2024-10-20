;; Sel
(define (quotient-terms L1 L2)
  (car (div-terms L1 L2)))
(define (remainder-terms L1 L2)
  (cadr (div-terms L1 L2)))
;; Proc
(define (div-terms L1 L2)
  (if (empty-termlist? L1) ; Base case (null remainder)
      (list (the-empty-termlist) (the-empty-termlist))
      (let ((t1 (first-term L1))
            (t2 (first-term L2)))
        (if (> (order t2) (order t1)) ; Base case (non-zero remainder)
            (list (the-empty-termlist) L1)
            (let ((new-c (div (coeff t1) (coeff t2)))
                  (new-o (- (order t1) (order t2))))
              (let ((rest-of-result
                      (div-terms (add-terms L1
                                            (negate-terms (mul-term-by-all-terms (make-term new-o new-c)
                                                                                 L2)))
                                  L2)))
                (list (adjoin-term (make-term new-o new-c) ; Reduction step -
                                   (car rest-of-result)) ; Recursively build up result
                      (cadr rest-of-result)))))))) ; Propagate remainder
