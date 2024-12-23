;;;; 4.57
;; Define a rule that says that person 1 can replace person 2 if either person 1 does the same job as person 2 or someone who does person 1's job can also do person 2's job, and if person 1 and person 2 are not the same person. Using your rule, give queries that find the following:
;;
;; a.  all people who can replace Cy D. Fect;
;;
;; b.  all people who can replace someone who is being paid more than they are, together with the two salaries.

;;; Answer
(load "4.logic.microshaft.run.scm")
;; a.
(assert!
  (rule (can-replace ?person-1 ?person-2)
        (and (job ?person-1 ?job-1)
             (job ?person-2 ?job-2)
             (or (same ?job-1 ?job-2)
                 (can-do-job ?job-1 ?job-2))
             (not (same ?person-1 ?person-2)))))
(can-replace ?x (fect cy d))
;; b.
(assert!
  (rule (cheaper-replacement ?person-1 ?person-2)
        (and (can-replace ?person-1 ?person-2)
             (salary ?person-1 ?salary-1)
             (salary ?person-2 ?salary-2)
             (lisp-value < ?salary-1 ?salary-2))))
(cheaper-replacement ?x ?y)
