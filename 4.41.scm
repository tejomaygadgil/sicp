;;;; 4.41
;; Write an ordinary Scheme program to solve the multiple dwelling puzzle.

;;; Answer
(load "0.util.scm")
(load "0.efma.scm")
(let ((baker (lambda (l) (list-ref l 0)))
      (cooper (lambda (l) (list-ref l 1)))
      (fletcher (lambda (l) (list-ref l 2)))
      (miller (lambda (l) (list-ref l 3)))
      (smith (lambda (l) (list-ref l 4))))
  (map print
       (map (lambda (l)
              (list (list 'baker (baker l))
                    (list 'cooper (cooper l))
                    (list 'fletcher (fletcher l))
                    (list 'miller (miller l))
                    (list 'smith (smith l))))
            (filter (lambda (l)
                      (and (not (= (baker l) 5))
                           (not (= (cooper l) 1))
                           (not (= (fletcher l) 5))
                           (not (= (fletcher l) 1))
                           (not (= (abs (- (fletcher l) (cooper l))) 1))
                           (not (= (abs (- (fletcher l) (smith l))) 1))
                           (> (miller l) (cooper l))))
                    (permutations '(1 2 3 4 5))))))
