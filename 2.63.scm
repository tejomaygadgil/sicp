;;;; 2.63
;; Each of the following two procedures converts a binary tree to a list.

(define (tree->list-1 tree)
  (if (null? tree)
    '()
    (append (tree->list-1 (left-branch tree))
            (cons (entry tree)
                  (tree->list-1 (right-branch tree))))))
(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
      result-list
      (copy-to-list (left-branch tree)
                    (cons (entry tree)
                          (copy-to-list (right-branch tree)
                                        result-list)))))
  (copy-to-list tree '()))

;; a. Do the two procedures produce the same result for every tree? If not, how do the results differ? What lists do the two procedures produce for the trees in figure 2.16?
;;
;; b. Do the two procedures have the same order of growth in the number of steps required to convert a balanced tree with n elements to a list? If not, which one grows more slowly?

;;; Answer
(load "2.binary-tree.scm")
(define tree1
  (make-tree 7
             (make-tree 3
                        (make-tree 1 () ())
                        (make-tree 5 () ()))
             (make-tree 9 ()
                        (make-tree 11 () ()))))
(define tree2
  (make-tree 3
             (make-tree 1 () ())
             (make-tree 7
                        (make-tree 5 () ())
                        (make-tree 9 ()
                                   (make-tree 11 () ())))))
(define tree3
  (make-tree 5
             (make-tree 3
                        (make-tree 1 () ())
                        ())
             (make-tree 9
                        (make-tree 7 () ())
                        (make-tree 11 () ()))))

(load "0.util.scm")
(test (tree->list-1 tree1) (tree->list-2 tree1))
(test (tree->list-1 tree2) (tree->list-2 tree2))
(test (tree->list-1 tree3) (tree->list-2 tree3))

;; a.
;; Both procedures produce the same result `(1 3 5 7 9 11)` for all trees.
(map (lambda (x)
       (display (tree->list-1 tree1))
       (display " ")
       (display (tree->list-2 tree1))
       (newline))
     (list tree1 tree2 tree3))

;; b.
;; While each procedure visits $n$ elements in $n$ steps, their actions at each step differ:
;;
;; For `(1 (2 () ()) (3 () ()))`,
;;
;; `list->tree-1`: `(append (append '() (cons 2 '())) (cons 1 (append '() (cons 3 '()))))`
;; `list->tree-2`: `(cons 2 (cons 1 (cons 3 '())))`
;;
;; `list->tree-2` grows slower than `list->tree-1` because it only applies `cons` and not also `append`, the former $\Theta(n)$ because `cons` is constant and the latter $\Theta(n \log n)$ due to the recursive application of linear `append`.
