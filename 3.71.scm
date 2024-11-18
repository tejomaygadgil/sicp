;;;; 3.71
;; Numbers that can be expressed as the sum of two cubes in more than one way are sometimes called *Ramanujan numbers*, in honor of the mathematician Srinivasa Ramanujan. Ordered streams of pairs provide an elegant solution to the problem of computing these numbers. To find a number that can be written as the sum of two cubes in two different ways, we need only generate the stream of pairs of integers $(i,j)$ weighted according to the sum $i3 + j3$ (see exercise 3.70), then search the stream for two consecutive pairs with the same weight. Write a procedure to generate the Ramanujan numbers. The first such number is 1,729. What are the next five?

;;; Answer
(load "3.70.scm")
(define ram-numbers
  (let ((cube-sum (lambda (s) (+ (expt (car s) 3)
                                 (expt (cadr s) 3)))))
    (let ((ram-pairs (weighted-pairs cube-sum integers integers)))
      (stream-map (lambda (x) (list (cube-sum (car x)) x))
                  (stream-filter (lambda (x) (apply = (map cube-sum x)))
                                 (stream-map list ram-pairs (stream-cdr ram-pairs)))))))

(display-n ram-numbers 0 10)
