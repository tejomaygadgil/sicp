;;;; 1.24
;; Modify the `timed-prime-test` procedure of exercise 1.22 to use `fast-prime?` (the Fermat method), and test each of the 12 primes you found in that exercise. Since the Fermat test has $\Theta(\log n)$ growth, how would you expect the time to test primes near 1,000,000 to compare with the time needed to test primes near 1000? Do your data bear this out? Can you explain any discrepancy you find?

;;; Answer
(load "1.prime-fermat.scm")
(define (timed-prime-test n)
  (define (start-prime-test n start-time)
    (if (fast-prime? n 10000)
        (report-prime n (- (runtime) start-time))))
  (define (report-prime n elapsed-time)
    (newline) ; Added
    (display n) ; Added
    (display " *** ")
    (display elapsed-time))
  (start-prime-test n (runtime)))

(define (search-for-primes lower upper)
  (define (iter n)
    (if (<= n upper)
      (begin
        (timed-prime-test n)
        (iter (+ n 2)))))
  (iter (if (odd? lower) lower (+ lower 1))) ; cf. http://community.schemewiki.org/?sicp-ex-1.22
  (newline))

;; Original range
(search-for-primes 1000 1019)
(search-for-primes 10000 10037)
(search-for-primes 100000 100043)
(search-for-primes 1000000 1000037)

;; Modified for modern computers
(search-for-primes 1000000000 1000000021)
(search-for-primes 10000000000 10000000061)
(search-for-primes 100000000000 100000000057)
(search-for-primes 1000000000000 1000000000063)

;; Time scales linearly with exponential growth of the input, confirming log n time complexity.
