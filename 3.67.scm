;;;; 3.67
;; Modify the `pairs` procedure so that `(pairs integers integers)` will produce the stream of *all* pairs of integers $(i,j)$ (without the condition $i < j$). Hint: You will need to mix in an additional stream.

;;; Answer
(load "3.streams.scm")
(define (interleave s1 s2)
  (if (stream-null? s1)
    s2
    (cons-stream (stream-car s1)
                 (interleave s2 (stream-cdr s1)))))
(define (pairs s t)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (interleave
      (stream-map (lambda (x) (list (stream-car s) x))
                  (stream-cdr t))
      (pairs (stream-cdr s) t)))) ; Changed

;; Test
(load "0.util.scm")
(until (pairs integers integers)
       (lambda (pair) (> (car pair) (cadr pair)))
       (lambda (stream) (display 'pass) (display " ") (display stream))
       1e5)
