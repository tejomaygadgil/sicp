;;;; 3.81
;; Exercise 3.6 discussed generalizing the random-number generator to allow one to reset the random-number sequence so as to produce repeatable sequences of "random" numbers. Produce a stream formulation of this same generator that operates on an input stream of requests to `generate` a new random number or to `reset` the sequence to a specified value and that produces the desired stream of random numbers. Don't use assignment in your solution.

;;; Answer
(load "3.streams.scm")
(define (init-rand rand-iter init-state)
  (define (dispatch curr-state m)
    (cond ((eq? m 'generate)
           (rand-iter curr-state))
          ((and (pair? m)
                (eq? (car m) 'reset))
           (rand-iter (cdr m)))
          (else (error "Unknown message -- INIT-RAND" m))))
  (define (process requests)
    (define responses
      (cons-stream (rand-iter init-state)
                   (stream-map dispatch responses requests)))
    responses)
  process)

;; Test
(load "0.util.scm")
(define (rand-iter x) (+ x 1))
(define init-state 0)
(define r1 (init-rand rand-iter init-state))
(define requests (list->stream
                   (list 'generate
                         'generate
                         (cons 'reset init-state)
                         'generate
                         'generate)))
(display-stream (r1 requests)) ; 1 2 3 1 2 3
