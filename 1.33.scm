;;;; 1.33
;; You can obtain an even more general version of `accumulate` (exercise 1.32) by introducing the notion of a *filter* on the terms to be combined. That is, combine only those terms derived from values in the range that satisfy a specified condition. The resulting `filtered-accumulate` abstraction takes the same arguments as `accumulate`, together with an additional predicate of one argument that specifies the filter. Write `filtered-accumulate` as a procedure. Show how to express the following using `filtered-accumulate`:
;;
;; a. the sum of the squares of the prime numbers in the interval a to b (assuming that you have a `prime?` predicate already written)
;;
;; b. the product of all the positive integers less than n that are relatively prime to $n$ (i.e., all positive integers $i < n$ such that $GCD(i,n) = 1$).

;;; Answer
(load "1.prime-divisor.scm")
(load "0.util.scm")
(define (filtered-accumulate combiner filter null-value term a next b)
  (if (> a b)
    null-value
    (combiner
      (if (filter a) (term a) null-value)
      (filtered-accumulate combiner filter null-value term (next a) next b))))

;; a.
(define (prime-sum-of-squares a b)
  (filtered-accumulate + prime? 0
                       square a 1+ b))

;; Test
(test (prime-sum-of-squares 1 10) (+ 1 4 9 25 49))

;; b.
(define (product-relative-primes n)
  (define (relative-prime? n)
    (lambda (x) (= (gcd n x) 1)))
  (filtered-accumulate * (relative-prime? n) 1
                       (lambda (x) x) 1 1+ (- n 1)))

;; Test
(test (product-relative-primes 10) 189)
