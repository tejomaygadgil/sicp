(load "4.74.logic.scm")
(load "4.74.scm")
(load "4.logic.microshaft.data.scm")
(initialize-data-base microshaft-data-base)
(newline) (display ";;; Microshaft data-base")
(query-driver-loop)

;; Test
(job ?x ?y)
