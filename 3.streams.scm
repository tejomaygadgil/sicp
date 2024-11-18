(load "3.stream.scm")
;; Proc
(define (add-streams s1 s2)
  (stream-map + s1 s2))
(load "3.54.mul-streams.scm")
(define (div-streams s1 s2)
  (stream-map / s1 s2))
(define (scale-stream stream factor)
  (stream-map (lambda (x) (* x factor)) stream))
;; Gen
(define (integers-starting-from n)
  (cons-stream n
               (integers-starting-from (+ n 1))))
(define (sieve s)
  (let ((not-divisible-by (lambda (y)
                            (let ((divisible? (lambda (x y) (= (remainder x y) 0))))
                              (lambda (x) (not (divisible? x y))))))
        (first-element (stream-car s)))
    (cons-stream first-element
                 (sieve (stream-filter (not-divisible-by first-element)
                                       s)))))
;; Streams
(define ones (cons-stream 1 ones))
(define alternating-ones (cons-stream 1 (scale-stream alternating-ones -1)))
(define integers (cons-stream 1 (add-streams ones integers)))
(define primes (sieve (integers-starting-from 2)))
(define fibs
  (cons-stream 0
               (cons-stream 1
                            (add-streams (stream-cdr fibs)
                                         fibs))))
