;;;; 3.54
;; Define a procedure `mul-streams`, analogous to `add-streams`, that produces the elementwise product of its two input streams. Use this together with the stream of integers to complete the following definition of the stream whose $n$th element (counting from 0) is $n + 1$ factorial:

;;; Answer
(define factorials
  (cons-stream 1
               (mul-streams (stream-cdr integers)
                            factorials)))
;; Test
(load "0.util.scm")
(load "3.streams.scm")
(test (stream-ref factorials 0) 1)
(test (stream-ref factorials 1) 2)
(test (stream-ref factorials 2) 6)
(test (stream-ref factorials 3) 24)
(test (stream-ref factorials 4) 120)
(test (stream-ref factorials 5) 720)
(test (stream-ref factorials 9) 3628800)
