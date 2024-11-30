;;;; 4.67
;; Devise a way to install a loop detector in the query system so as to avoid the kinds of simple loops illustrated in the text and in exercise 4.64. The general idea is that the system should maintain some sort of history of its current chain of deductions and should not begin processing a query that it is already working on. Describe what kind of information (patterns and frames) is included in this history, and how the check should be made. (After you study the details of the query-system implementation in section 4.4.4, you may want to modify the system to include your loop detector.)

;; Test
(load "4.67.logic.microshaft.run.scm")
;; Text
(assert! (rule (married ?x ?y)
               (married ?y ?x)))
(married Mickey ?who)
;; Ex 4.64
(assert!
  (rule (outranked-by ?staff-person ?boss)
        (or (supervisor ?staff-person ?boss)
            (and (outranked-by ?middle-manager ?boss)
                (supervisor ?staff-person ?middle-manager)))))
(outranked-by (Bitdiddle Ben) ?who)
