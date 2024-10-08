;;;; 2.29
;; A binary mobile consists of two branches, a left branch and a right branch. Each branch is a rod of a certain length, from which hangs either a weight or another binary mobile. We can represent a binary mobile using compound data by constructing it from two branches (for example, using `list`):

(define (make-mobile left right)
  (list left right))

;; A branch is constructed from a length (which must be a number) together with a structure, which may be either a number (representing a simple weight) or another mobile:

(define (make-branch length structure)
  (list length structure))

;; a.  Write the corresponding selectors `left-branch` and `right-branch`, which return the branches of a mobile, and `branch-length` and `branch-structure`, which return the components of a branch.
;;
;; b.  Using your selectors, define a procedure `total-weight` that returns the total weight of a mobile.
;;
;; c.  A mobile is said to be *balanced* if the torque applied by its top-left branch is equal to that applied by its top-right branch (that is, if the length of the left rod multiplied by the weight hanging from that rod is equal to the corresponding product for the right side) and if each of the submobiles hanging off its branches is balanced. Design a predicate that tests whether a binary mobile is balanced.
;;
;; d.  Suppose we change the representation of mobiles so that the constructors are
;;
;; (define (make-mobile left right)
;;   (cons left right))
;; (define (make-branch length structure)
;;   (cons length structure))
;;
;; How much do you need to change your programs to convert to the new representation?

;;; Answer
;; a.
(define (left-branch mobile) (car mobile))
(define (right-branch mobile) (cadr mobile))
(define (branch-length branch) (car branch))
(define (branch-structure branch) (cadr branch))

;; b.
(define (total-weight mobile)
  (if (not (pair? mobile)) mobile
    (+ (total-weight (branch-structure (left-branch mobile)))
       (total-weight (branch-structure (right-branch mobile))))))

;; c.
(define (is-balanced? mobile)
  (if (not (pair? mobile)) #t
    (let ((left (left-branch mobile))
          (right (right-branch mobile)))
      (and (= (* (branch-length left) (total-weight (branch-structure left)))
              (* (branch-length right) (total-weight (branch-structure right))))
           (is-balanced? (branch-structure left))
           (is-balanced? (branch-structure right))))))


;; Test
(load "0.util.scm")
(define a (make-mobile (make-branch 2 3) (make-branch 2 3)))
(define b (make-mobile
            (make-branch 2 3)
            (make-branch 4 (make-mobile
                             (make-branch 5 6)
                             (make-branch 7 8)))))
(define c (make-mobile
            (make-branch 10 4)
            (make-branch 4 (make-mobile
                             (make-branch 24 2)
                             (make-branch 6 8)))))
(define d (make-mobile
            (make-branch 10 4)
            (make-branch 4 (make-mobile
                             (make-branch 20 2)
                             (make-branch 6 8)))))
(test (is-balanced? a) #t)
(test (is-balanced? b) #f)
(test (is-balanced? c) #t)
(test (is-balanced? d) #f)

;; d.
(define (make-mobile left right)
  (cons left right))
(define (make-branch length structure)
  (cons length structure))
;; Required changes
(define (right-branch mobile) (cdr mobile))
(define (branch-structure branch) (cdr branch))
