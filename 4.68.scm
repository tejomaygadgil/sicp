;;;; 4.68
;; Define rules to implement the reverse operation of exercise 2.18, which returns a list containing the same elements as a given list in reverse order. (Hint: Use `append-to-form`.) Can your rules answer both `(reverse (1 2 3) ?x)` and `(reverse ?x (1 2 3))`?

;;; Answer
(load "4.logic.run.scm")
(assert! (rule (append-to-form () ?y ?y))) ; Base case
(assert! (rule (append-to-form (?car-x . ?cdr-x) ?y (?car-x . ?z))
               (append-to-form ?cdr-x ?y ?z))) ; Recurse
(assert! (rule (reverse () ())))
(assert! (rule (reverse (?car-x . ?cdr-x) ?z)
               (and (reverse ?cdr-x ?y)
                    (append-to-form ?y (?car-x) ?z))))

;; Test
(reverse (1 2 3) ?x) ; Works
(reverse ?x (1 2 3)) ; Hangs
;; Swapping `reverse` with `append-to-form`
;; flips the outcome of the two expressions.
