;;;; 2.66
;; Implement the `lookup` procedure for the case where the set of records is structured as a binary tree, ordered by the numerical values of the keys.

;;; Answer
(load "2.binary-tree.scm")
(define (lookup given-key set-of-records)
  (if (null? set-of-records) false
    (let ((entry-key (entry set-of-records)))
      (cond ((= given-key entry-key) entry-key)
            ((< given-key entry-key)
             (lookup given-key
                     (left-branch set-of-records)))
            (else
              (lookup given-key
                      (right-branch set-of-records)))))))

;; Test
(load "0.util.scm")
(define s1 (list->tree (list 1 3 5 7 9)))
(define s2 (list->tree (list 2 4 6 8 10)))
(define s3 (list->tree (list 3 5 7 9 11)))
(test (lookup 3 s1) 3)
(test (lookup 8 s1) false)
