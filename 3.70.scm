;;;; 3.70
;; It would be nice to be able to generate streams in which the pairs appear in some useful order, rather than in the order that results from an `ad hoc` interleaving process. We can use a technique similar to the `merge` procedure of exercise 3.56, if we define a way to say that one pair of integers is "less than" another. One way to do this is to define a "weighting function" $W(i,j)$ and stipulate that $(i_1,j_1)$ is less than $(i_2,j_2)$ if $W(i_1,j_1) < W(i_2,j_2)$. Write a procedure `merge-weighted` that is like `merge`, except that `merge-weighted` takes an additional argument `weight`, which is a procedure that computes the weight of a pair, and is used to determine the order in which elements should appear in the resulting merged stream. Using this, generalize `pairs` to a procedure `weighted-pairs` that takes two streams, together with a procedure that computes a weighting function, and generates the stream of pairs, ordered according to weight. Use your procedure to generate
;;
;; a. the stream of all pairs of positive integers $(i,j)$ with $i < j$ ordered according to the sum $i + j$
;;
;; b. the stream of all pairs of positive integers $(i,j)$ with $i < j$, where neither $i$ nor $j$ is divisible by 2, 3, or 5, and the pairs are ordered according to the sum $2 i + 3 j + 5 i j$.


;;; Answer
(load "3.streams.scm")
(load "3.stream.pairs.scm")
(define (weighted-pairs weight s t)
  (define (merge-weighted weight s1 s2)
    (let iter ((s1 s1)
               (s2 s2))
      (cond ((stream-null? s1) s2)
            ((stream-null? s2) s1)
            (else
              (let ((w1 (weight (stream-car s1)))
                    (w2 (weight (stream-car s2))))
                (cond ((< w1 w2)
                       (cons-stream (stream-car s1)
                                    (iter (stream-cdr s1) s2)))
                      ((> w1 w2)
                       (cons-stream (stream-car s2)
                                    (iter s1 (stream-cdr s2))))
                      (else
                        (cons-stream (stream-car s1)
                                     (cons-stream (stream-car s2)
                                                  (iter (stream-cdr s1) (stream-cdr s2)))))))))))
  (cons-stream
    (list (stream-car s) (stream-car t))
    (merge-weighted weight
                    (stream-map (lambda (x) (list (stream-car s) x))
                                (stream-cdr t))
                    (weighted-pairs weight (stream-cdr s) (stream-cdr t)))))
(define a
  (weighted-pairs (lambda (x) (apply + x))
                  integers integers))
(define hamming-stream
  (stream-filter (lambda (x)
                   (and (not (= (modulo x 2) 0))
                        (not (= (modulo x 3) 0))
                        (not (= (modulo x 5) 0))))
                 integers))
(define b
  (weighted-pairs (lambda (x)
                    (+ (* 2 (car x))
                       (* 3 (cadr x))
                       (* 5 (car x) (cadr x))))
    hamming-stream hamming-stream))

;; ;; Test
;; (display-n a 0 10)
;; (display-n b 0 10)
