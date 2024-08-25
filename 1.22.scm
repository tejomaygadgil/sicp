;;;; 1.22
;; Most Lisp implementations include a primitive called `runtime` that returns an integer that specifies the amount of time the system has been running (measured, for example, in microseconds). The following `timed-prime-test` procedure, when called with an integer $n$, prints $n$ and checks to see if $n$ is prime. If $n$ is prime, the procedure prints three asterisks followed by the amount of time used in performing the test.
;;
;; (define (timed-prime-test n)
;;   (newline)
;;   (display n)
;;   (start-prime-test n (runtime)))
;; (define (start-prime-test n start-time)
;;   (if (prime? n)
;;       (report-prime (- (runtime) start-time))))
;; (define (report-prime elapsed-time)
;;   (display " *** ")
;;   (display elapsed-time))
;;
;; Using this procedure, write a procedure `search-for-primes` that checks the primality of consecutive odd integers in a specified range. Use your procedure to find the three smallest primes larger than 1000; larger than 10,000; larger than 100,000; larger than 1,000,000. Note the time needed to test each prime. Since the testing algorithm has order of growth of $\Theta(\sqrt n)$, you should expect that testing for primes around 10,000 should take about 10 times as long as testing for primes around 1000. Do your timing data bear this out? How well do the data for 100,000 and 1,000,000 support the $\sqrt n$ prediction? Is your result compatible with the notion that programs on your machine run in time proportional to the number of steps required for the computation?

;;; Answer
(load "1.prime-divisor.scm")
(define (timed-prime-test n) ; Modified to only print primes
  (define (start-prime-test n start-time)
    (if (prime? n)
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

;; Each line takes ~sqrt(10) longer to run than the previous one.
