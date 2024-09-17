;;;; 2.32
;; We can represent a set as a list of distinct elements, and we can represent the set of all subsets of the set as a list of lists. For example, if the set is `(1 2 3)`, then the set of all subsets is `(() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3))`. Complete the following definition of a procedure that generates the set of subsets of a set and give a clear explanation of why it works:
;;
;; (define (subsets s)
;;   (if (null? s)
;;       (list nil)
;;       (let ((rest (subsets (cdr s))))
;;         (append rest (map <??> rest)))))

;;; Answer
(define (subsets s)
  (if (null? s) (list '())
      (let ((rest (subsets (cdr s))))
        (append rest
                (map (lambda (l) (cons (car s) l)) rest)))))

;; The set of all subsets of $S$ is sets that contain some element $s \in S$ plus sets that do not. The former is defined as the latter plus $s$: our procedure applies this logic recursively.

;; Test
(load "0.util.scm")
(test (subsets (1 2 3)) '(() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3)))
