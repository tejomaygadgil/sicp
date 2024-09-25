;;;; 2.69
;; The following procedure takes as its argument a list of symbol-frequency pairs (where no symbol appears in more than one pair) and generates a Huffman encoding tree according to the Huffman algorithm.

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

;; `Make-leaf-set` is the procedure given above that transforms the list of pairs into an ordered set of leaves. `Successive-merge` is the procedure you must write, using `make-code-tree` to successively merge the smallest-weight elements of the set until there is only one element left, which is the desired Huffman tree. (This procedure is slightly tricky, but not really complicated. If you find yourself designing a complex procedure, then you are almost certainly doing something wrong. You can take significant advantage of the fact that we are using an ordered set representation.)

;;; Answer
(load "2.68.scm")
(load "2.huffman.scm")
(define (successive-merge pairs)
  (if (null? (cdr pairs)) (car pairs)
    (successive-merge
      (adjoin-set
        (make-code-tree (car pairs) (cadr pairs))
        (cddr pairs)))))

;; ;; Test
;; (load "0.util.scm")
;; (define s1 (list (list 'A 8) (list 'B 3)
;;                  (list 'C 1) (list 'D 1)
;;                  (list 'E 1) (list 'F 1)
;;                  (list 'G 1) (list 'H 1)))
;; (print (generate-huffman-tree s1))
