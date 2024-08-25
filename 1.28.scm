;;;; 1.28
;; One variant of the Fermat test that cannot be fooled is called the Miller-Rabin test (Miller 1976; Rabin 1980). This starts from an alternate form of Fermat's Little Theorem, which states that if $n$ is a prime number and $a$ is any positive integer less than $n$, then $a$ raised to the $(n - 1)$st power is congruent to 1 modulo $n$. To test the primality of a number $n$ by the Miller-Rabin test, we pick a random number $a < n$ and raise $a$ to the $(n - 1)$st power modulo $n$ using the `expmod` procedure. However, whenever we perform the squaring step in `expmod`, we check to see if we have discovered a "nontrivial square root of 1 modulo n," that is, a number not equal to 1 or $n - 1$ whose square is equal to 1 modulo $n$. It is possible to prove that if such a nontrivial square root of 1 exists, then $n$ is not prime. It is also possible to prove that if $n$ is an odd number that is not prime, then, for at least half the numbers $a < n$, computing $a^{n - 1}$ in this way will reveal a nontrivial square root of 1 modulo $n$. (This is why the Miller-Rabin test cannot be fooled.) Modify the `expmod` procedure to signal if it discovers a nontrivial square root of 1, and use this to implement the Miller-Rabin test with a procedure analogous to `fermat-test`. Check your procedure by testing various known primes and non-primes. Hint: One convenient way to make `expmod` signal is to have it return 0.

;;; Answer
(load "1.prime-fermat.scm")
(define (miller-rabin-prime? n i)
  (define (expmod a m n)
    (define (miller-rabin x n)
      (let ((s (remainder (square x) n)))
        (if (and (= s 1) (not (= x 1)) (not (= x (- n 1))))
          0 s)))
    (cond ((= m 0) 1)
          ((= (remainder m 2) 0)
           (miller-rabin (expmod a (/ m 2) n) n))
          (else
            (remainder (* a (expmod a (- m 1) n)) n))))
  (define (fermat-test n)
    (let ((a (+ 1 (random (- n 1)))))
      (= (expmod a n n) a)))
  (cond ((= i 0) #t)
        ((fermat-test n) (miller-rabin-prime? n (- i 1)))
        (else #f)))

(define fermat-liars '(561 1105 1729 2465 2821 6601))
(define n 100)
(map (lambda (x)
       (display x) (display "\t")
       (if (fast-prime? x n)
         (begin
           (display "fooled fast-prime?")
           (if (miller-rabin-prime? x n)
             (display " and miller-rabin-prime?")
             (display " but not miller-rabin-prime?")))
         (begin
           (display "did not fool fast-prime?")
           (if (miller-rabin-prime? x n)
             (display " but fooled miller-rabin-prime?")
             (display " not miller-rabin-prime?"))))
       (newline))
     fermat-liars)

;; Miller-Rabin catches Fermat liars (non-primes that satisfy Fermat's Little Theorem) by testing for non-trivial ($x \ne 1, n -1$) roots to $x^2 \equiv 1 \pmod{n}$ --
;; Prime numbers in some sense guarantee a "sound" modular arithmetic: if you make a clock with a prime number of hours, you can do math on it that makes sense. Particularly, $x^2 = 1$ should only have the expected roots of $1 (+ n*k)$ and $-1 + (n*k)$. So when things don't add up you can be sure you have found composition (e.g. $4$ is a root of $x^2 \equiv 1 \pmod{8}$).
