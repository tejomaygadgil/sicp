;;;; 1.23
;; The `smallest-divisor` procedure shown at the start of this section does lots of needless testing: After it checks to see if the number is divisible by 2 there is no point in checking to see if it is divisible by any larger even numbers. This suggests that the values used for `test-divisor` should not be 2, 3, 4, 5, 6, ..., but rather 2, 3, 5, 7, 9, .... To implement this change, define a procedure `next` that returns 3 if its input is equal to 2 and otherwise returns its input plus 2. Modify the `smallest-divisor` procedure to use `(next test-divisor)` instead of `(+ test-divisor 1)`. With `timed-prime-test` incorporating this modified version of `smallest-divisor`, run the test for each of the 12 primes found in exercise 1.22. Since this modification halves the number of test steps, you should expect it to run about twice as fast. Is this expectation confirmed? If not, what is the observed ratio of the speeds of the two algorithms, and how do you explain the fact that it is different from 2?

;;; Answer
(load "1.prime-divisor.scm")
(define (fast-smallest-divisor n)
  (define (next n) (if (= n 2) 3 (+ n 2)))
  (define (find-divisor n test-divisor)
    (cond ((> (square test-divisor) n) n)
          ((= (remainder n test-divisor) 0) test-divisor)
          (else (find-divisor n (next test-divisor)))))
  (find-divisor n 2))

(define (time-test f n)
  (let ((t (real-time-clock)))
    (begin
      (display (f n))
      (display ": ")
      (display (- (real-time-clock) t))
      (newline))))

;; Compare performance
(time-test fast-smallest-divisor 1000003)
(time-test fast-smallest-divisor 1000033)
(time-test fast-smallest-divisor 1000037)
(time-test smallest-divisor 1000003)
(time-test smallest-divisor 1000033)
(time-test smallest-divisor 1000037)
(newline)

(time-test fast-smallest-divisor 100000007)
(time-test fast-smallest-divisor 100000037)
(time-test fast-smallest-divisor 100000039)
(time-test smallest-divisor 100000007)
(time-test smallest-divisor 100000037)
(time-test smallest-divisor 100000039)
(newline)

(time-test fast-smallest-divisor 1000000007)
(time-test fast-smallest-divisor 1000000009)
(time-test fast-smallest-divisor 1000000021)
(time-test smallest-divisor 1000000007)
(time-test smallest-divisor 1000000009)
(time-test smallest-divisor 1000000021)
(newline)

;; `fast-smallest-divisor` is closer to 1.5x faster than `smallest-divisor` than 2x --
;; This is due to the `if` clause inside of `next` which the prompt does not account for.
