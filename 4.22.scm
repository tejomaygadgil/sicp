;;;; 4.22
;; Extend the evaluator in this section to support the special form `let`. (See exercise 4.6.)

;;; Answer
;; We implement Ex 4.8 instead for naemd let.

;; Test
(load "0.util.scm")
(load "4.analyze.scm") ; Loads 4.22.analyze.let.scm
(define l1 '(let ((x 1)) (+ x 1))) ; Normal let
(define l2 '(let f ((x 10)) ; Named let
               (if (= x 1) x
                 (* (f (- x 1))
                    x))))
(test (eval l1 the-global-environment) 2)
(test (eval l2 the-global-environment) 3628800)
