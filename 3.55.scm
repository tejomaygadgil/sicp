;;;; 3.55
;; Define a procedure `partial-sums` that takes as argument a stream $S$ and returns the stream whose elements are $S_0, S_0 + S_1, S_0 + S_1 + S_2, ...$. For example, `(partial-sums integers)` should be the stream $1, 3, 6, 10, 15, ...$.

;;; Answer
;; Partial sums commute! We are free to describe the process as
;; a sum of streams, or a stream of sums:
(define (partial-sums s)
  (define partial-sum (add-streams s
                                   (cons-stream 0
                                                partial-sum)))
  partial-sum)
(define (partial-sums s)
  (define partial-sum (cons-stream (stream-car s)
                                   (add-streams (stream-cdr s)
                                                partial-sum)))
  partial-sum)

;; ;; Test
;; (load "0.util.scm")
;; (load "3.streams.scm")
;; (define S (partial-sums integers))
;; (test (stream-ref S 0) 1)
;; (test (stream-ref S 1) 3)
;; (test (stream-ref S 2) 6)
;; (test (stream-ref S 3) 10)
;; (test (stream-ref S 4) 15)
;; (test (stream-ref S 5) 21)
;; (test (stream-ref S 6) 28)
;; (test (stream-ref S 7) 36)

;; As LisScheSic suggests (http://community.schemewiki.org/?sicp-ex-3.55),
;; explicit self-reference is required to avoid massive performance loss
;; as the stream progresses. This is due to the recursion inherent in what
;; a sequence of partial sums even is: the accumulated sums as we sweep
;; across every element of a base sequence necessitates recomputation.
;;
;; Streams solve this problem elegantly by utilizing "call-by-need" caching:
;; the next sum simply adds to the previous one instead of having to compute
;; it from scratch:
;;
;; $$\text{sum}_{i+1} = \text{stream}_i + \text{sum}_i$$
;;   ^ Next sum         ^ Next value      ^ Memoized!
;;
;; Procedural representations of this process do not memoize past results,
;; forcing each subsequent sum to recompute from scratch
;;
;; (define (partial-sums s)
;;   (cons-stream (stream-car s)
;;                (add-streams (stream-cdr s)
;;                             (partial-sums s)))) ; Recalculates
;; (define (partial-sums s)
;;   (add-streams s
;;                (cons-stream 0
;;                             (partial-sums s)))) ; Recalculates
;;
;; To understand this difficulty is to notice the difference between referring
;; to data and to procedures. The former finds a value in an environment (eval),
;; while the latter creates a new environment with parameters bound to arguments
;; (apply). The data representation will always point to the previous stream
;; created in the underlying `stream-map`, while the procedural representation
;; kicks off the construction of a new, disconnected stream from the ground up.
;; (This is also why `(memoize fib)` does not work in Ex 3.27.)
;;
;; It is interesting to think about where streams successfully blur the line
;; between procedure and data, and where they do not:
;;
;; (define ones (cons-stream 1 ones))
;; (define (ones) (cons-stream 1 (ones))) ; What's the difference?
