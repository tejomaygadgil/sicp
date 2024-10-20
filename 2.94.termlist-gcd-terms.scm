(define (gcd-terms L1 L2)
  (if (empty-termlist? L2)
    L1
    (gcd-terms L2 (remainder-terms L1 L2)))) ; Already exists!
