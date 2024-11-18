;;;; 3.69
;; Write a procedure `triples` that takes three infinite streams, $S$, $T$, and $U$, and produces the stream of triples $(S_i,T_j,U_k)$ such that $i < j < k$. Use `triples` to generate the stream of all Pythagorean triples of positive integers, i.e., the triples $(i,j,k)$ such that $i < j$ and $i^2 + j^2 = k^2$.

;;; Answer
(load "3.streams.scm")
(load "3.stream.pairs.scm")
(define (triples s t u)
  (cons-stream
    (list (stream-car s) (stream-car t) (stream-car u))
    (interleave
      (stream-map (lambda (x) (cons (stream-car s) x))
                  (pairs (stream-cdr t) (stream-cdr u)))
      (triples (stream-cdr s) (stream-cdr t) (stream-cdr u)))))
(define pythagorean-triples
  (stream-filter
    (lambda (x)
      (let ((squared (map square x)))
        (= (+ (car squared)
              (cadr squared))
           (caddr squared))))
    (triples integers integers integers)))

;; Test
(display-n pythagorean-triples 0 6)
