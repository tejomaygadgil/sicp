;;;; 4.76
;; Our implementation of `and` as a series combination of queries (figure 4.5) is elegant, but it is inefficient because in processing the second query of the `and` we must scan the data base for each frame produced by the first query. If the data base has $N$ elements, and a typical query produces a number of output frames proportional to $N$ (say $N/k$), then scanning the data base for each frame produced by the first query will require $N^2 / k$ calls to the pattern matcher. Another approach would be to process the two clauses of the `and` separately, then look for all pairs of output frames that are compatible. If each query produces $N/k$ output frames, then this means that we must perform $N^2/k^2$ compatibility checks -- a factor of $k$ fewer than the number of matches required in our current method.
;;
;; Devise an implementation of `and` that uses this strategy. You must implement a procedure that takes two frames as inputs, checks whether the bindings in the frames are compatible, and, if so, produces a frame that merges the two sets of bindings. This operation is similar to unification.

;; Test
(load "4.76.logic.microshaft.run.scm")
;; Unification works
(assert! (rule (append-to-form () ?y ?y))) ; Base case
(assert! (rule (append-to-form (?car-x . ?cdr-x) ?y (?car-x . ?z))
               (append-to-form ?cdr-x ?y ?z))) ; Recurse
(and (append-to-form (1 2) (3 4) ?x)
     (append-to-form (1) ?y ?x))
;; Testing Ex 4.56, we observe that the proposed solution
;; does not handle `lisp-value` and `not` special forms
;; that rely on previous frame-streams:
(and (supervisor ?name (Bitdiddle Ben))
     (address ?name ?where))
(and (job ?supervisor ?supervisor-job)
     (supervisor ?name ?supervisor)
     (not (job ?supervisor (computer . ?job)))) ; Returns empty quuery
(and (salary ?name ?salary)
     (salary (Bitdiddle Ben) ?ben-salary)
     (lisp-value > ?ben-salary ?salary)) ; Doesn't work
