;;;; 3.6
;; It is useful to be able to reset a random-number generator to produce a sequence starting from a given value. Design a new `rand` procedure that is called with an argument that is either the symbol generate or the symbol reset and behaves as follows: `(rand 'generate)` produces a new random number; `((rand 'reset) <new-value>)` resets the internal state variable to the designated `<new-value>`. Thus, by resetting the state, one can generate repeatable sequences. These are very handy to have when testing and debugging programs that use random numbers.

;;; Answer
(define (init-rand update state)
  (define (rand)
    (set! state (update state))
    state)
  (define (reset new-value)
    (set! state new-value))
  (define (dispatch m)
    (cond ((eq? m 'generate) (rand))
          ((eq? m 'reset) reset)
          (else (error "Unknown request -- INIT-RAND" m))))
  dispatch))

;; Test
(load "0.util.scm")
(define (iter x) (+ x 1))
(define r1 (init-rand iter 0)) ; Init
(test (r1 'generate) 1)
(test (r1 'generate) 2)
((r1 'reset) 0) ; Reset
(test (r1 'generate) 1)
(test (r1 'generate) 2)
