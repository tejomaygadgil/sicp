;;;; 2.30
;; Define a procedure square-tree analogous to the `square-list` procedure of exercise 2.21. That is, `square-list` should behave as follows:
;;
;; (square-tree
;;  (list 1
;;        (list 2 (list 3 4) 5)
;;        (list 6 7)))
;; (1 (4 (9 16) 25) (36 49))
;;
;; Define `square-tree` both directly (i.e., without using any higher-order procedures) and also by using `map` and recursion.

;;; Answer
(define (square-tree l)
  (cond ((null? l) ())
        ((not (pair? l)) (* l l))
        (else (cons (square-tree (car l))
                    (square-tree (cdr l))))))

(define (square-tree l)
  (map (lambda (l)
          (cond ((null? l) ())
                ((not (pair? l)) (* l l))
                (else (square-tree l))))
        l))
