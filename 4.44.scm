;;;; 4.44
;; Exercise 2.42 described the "eight-queens puzzle" of placing queens on a chessboard so that no two attack each other. Write a nondeterministic program to solve this puzzle.

;;; Answer
(load "4.amb.preamble.scm")
(define queens
  '(let ((board-size 8)
         (col (lambda (piece) (car piece)))
         (row (lambda (piece) (cdr piece)))
         (queen (lambda (col board-size) (cons col (an-integer-between 1 board-size)))))
     (let iter ((acc '()))
       (require (distinct? (map row acc))) ; unique row
       (require (distinct? (map (lambda (q) (- (col q) (row q))) acc))) ; unique upward diagonal
       (require (distinct? (map (lambda (q) (+ (col q) (row q))) acc))) ; unique downward diagonal
       (if (= board-size (length acc)) acc
         (iter (cons (queen (- board-size (length acc))
                            board-size)
                     acc))))))

;; Test
(load "4.amb.scm")
(load "4.35.an-integer-between.scm")
(install-an-integer-between)
(print-amb queens)
