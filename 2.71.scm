(load "0.util.scm")
(load "2.69.scm")
(define exponents '(1 2 3 4 5))

;; Plain values
(define 2-n-growth (map (lambda (x) (list (expt 2 (- x 1))
                                          (expt 2 (- x 1))))
                        exponents))
(define huffman-tree (generate-huffman-tree 2-n-growth))
(print huffman-tree)

;; Rank ordering
(define 2-n-rank (map (lambda (x) (list (expt 2 (- x 1)) x))
                      exponents))
(define huffman-tree (generate-huffman-tree 2-n-rank))
(print huffman-tree)
