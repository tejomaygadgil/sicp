;;;; 1.27
;; Demonstrate that the Carmichael numbers listed in footnote 47 really do fool the Fermat test. That is, write a procedure that takes an integer $n$ and tests whether $a^n$ is congruent to $a$ modulo $n$ for every $a < n$, and try your procedure on the given Carmichael numbers.

;;; Answer
(load "1.prime-fermat.scm")
(load "1.prime-divisor.scm")
(define fermat-liars '(561 1105 1729 2465 2821 6601))
(define n 100)

(newline)
(display "Fermat test (n=") (display n) (display ")")
(newline)
(map (lambda (x)
       (display x) (display "\t")
       (if (fast-prime? x n)
         (begin
           (display "fooled fast-prime?")
           (if (prime? x)
             (display " and prime?")
             (display " but not prime?")))
         (begin
           (display "did not fool fast-prime?")
           (if (prime? x)
             (display " but fooled prime?")
             (display " not prime?"))))
       (newline))
     fermat-liars)
