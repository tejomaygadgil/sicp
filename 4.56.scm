;;;; 4.56
;; Formulate compound queries that retrieve the following information:
;;
;; a. the names of all people who are supervised by Ben Bitdiddle, together with their addresses;
;;
;; b. all people whose salary is less than Ben Bitdiddle's, together with their salary and Ben Bitdiddle's salary;
;;
;; c. all people who are supervised by someone who is not in the computer division, together with the supervisor's name and job.

;;; Answer
(load "4.logic.microshaft.run.scm")
;; a.
(and (supervisor ?name (Bitdiddle Ben))
     (address ?name ?where))
;; b.
(and (salary ?name ?salary)
     (salary (Bitdiddle Ben) ?ben-salary)
     (lisp-value > ?ben-salary ?salary))
;; c.
(and (job ?supervisor ?supervisor-job)
     (supervisor ?name ?supervisor)
     (not (job ?supervisor (computer . ?job))))
