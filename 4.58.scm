;;;; 4.58
;; Define a rule that says that a person is a "big shot" in a division if the person works in the division but does not have a supervisor who works in the division.

;;; Answer
(load "4.logic.microshaft.run.scm")
(assert!
  (rule (bigshot ?person-1 ?division-1)
        (and (job ?person-1 (?division-1 . ?job-1))
             (or (and (supervisor ?person-1 ?person-2)
                      (job ?person-2 (?division-2 . ?job-2))
                      (not (same ?division-1 ?division-2)))
                 (not (supervisor ?person-1 ?person-2))))))
(bigshot ?x ?y)
