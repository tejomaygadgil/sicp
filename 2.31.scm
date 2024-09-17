;;;; 2.31
;; Abstract your answer to exercise 2.30 to produce a procedure tree-map with the property that `square-tree` could be defined as
;;
;; (define (square-tree tree) (tree-map square tree))

;;; Answer
(define (tree-map proc tree)
  (cond ((null? tree) ())
        ((not (pair? tree)) (proc tree))
        (else (cons (tree-map proc (car tree))
                    (tree-map proc (cdr tree))))))
