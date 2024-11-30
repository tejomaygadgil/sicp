;; Interface
(load "3.stream.scm")
(load "3.stream.pairs.scm")
(load "4.logic.tagged-data.scm")
(load "4.logic.rule.scm")
(load "4.logic.frame.scm")
(load "4.logic.env.scm")
(load "4.logic.query.scm")
(load "4.logic.stream.scm")
;; Core
(load "4.logic.qeval.scm")
(load "4.logic.simple-query.scm")
(load "4.67.logic.apply-rules.scm") ; Changed
(load "4.logic.matcher.scm")
(load "4.logic.unifier.scm")
(load "4.logic.instantiate.scm")
;; Setup
(load "4.67.logic.hist.scm") ; Added
(load "4.67.logic.driver.scm") ; Changed
(load "4.logic.data-base.scm")
(load "4.logic.data-base.rule.scm")
(load "4.logic.data-base.assertion.scm")
;; Packages
(load "0.table.scm")
(load "4.logic.conjoin.scm")
(load "4.logic.disjoin.scm")
(load "4.logic.negate.scm")
(load "4.logic.lisp-value.scm")
(load "4.logic.always-true.scm")
(load "4.logic.load.scm")
;; Install
(define rule-counter 0)
(define tries 0)
(define tries-limit 50)
(define hist (make-hist))
(define *op-table* (make-hash-table))
(install-conjoin-package)
(install-disjoin-package)
(install-negate-package)
(install-lisp-value-package)
(install-always-true-package)
(install-load-package)
