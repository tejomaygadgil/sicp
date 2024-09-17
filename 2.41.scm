;;;; 2.41
;; Write a procedure to find all ordered triples of distinct positive integers $i$, $j$, and $k$ less than or equal to a given integer $n$ that sum to a given integer $s$.

;;; Answer
(load "0.efma.scm")
(define (ordered-triples n s)
  (filter (lambda (x) (= (accumulate + 0 x) s))
    (flatmap (lambda (i)
      (flatmap (lambda (j)
        (map (lambda (k) (list k j i))
          (enumerate-interval 1 (- j 1))))
        (enumerate-interval 1 (- i 1))))
      (enumerate-interval 1 n))))

;; Test
(load "0.util.scm")
(test (ordered-triples 5 10) '((2 3 5) (1 4 5)))
