;;;; 2.40
;; Define a procedure `unique-pairs` that, given an integer $n$, generates the sequence of pairs $(i, j)$ with $1 <= j <= i <= n$. Use `unique-pairs` to simplify the definition of `prime-sum-pairs` given above.

;;; Answer
(load "0.efma.scm")
(define (unique-pairs n)
  (filter (lambda (x) (< (car x) (cadr x)))
          (flatmap (lambda (i) (map (lambda (j) (list j i))
                                    (enumerate-interval 1 i)))
                   (enumerate-interval 1 n))))

;; Test
(load "0.util.scm")
(test (unique-pairs 3) '((1 2) (1 3) (2 3)))
