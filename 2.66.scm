;;;; 2.66
;; Implement the `lookup` procedure for the case where the set of records is structured as a binary tree, ordered by the numerical values of the keys.

;; Test
(load "0.util.scm")
(load "2.66.lookup.scm")
(define s1 (list->tree
             (list (cons 1 'a)
                   (cons 3 'b)
                   (cons 5 'c)
                   (cons 7 'd)
                   (cons 9 'e))))
(test (lookup 3 s1) (cons 3 'b))
(test (lookup 8 s1) false)
