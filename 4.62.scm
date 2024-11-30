;;;; 4.62
;; Define rules to implement the `last-pair` operation of exercise 2.17, which returns a list containing the last element of a nonempty list. Check your rules on queries such as `(last-pair (3) ?x)`, `(last-pair (1 2 3) ?x)`, and `(last-pair (2 ?x) (3))`. Do your rules work correctly on queries such as `(last-pair ?x (3))`?

;; Test
(load "4.logic.run.scm")
(load "4.62.last-pair.scm")
(last-pair (3) ?x)
(last-pair (1 2 3) ?x)
(last-pair (2 ?x) (3))
(last-pair ?x (3)) ; Hangs
;; The last query does not resolve because there are infinite instances.
