;; Util
(load "0.table.scm")
(load "3.stream.scm")
(load "3.stream.pairs.scm")
(load "3.50.stream-map.scm")
(load "4.query.stream.scm")
;; Core
(load "4.query.qeval.scm")
(load "4.query.apply.scm")
;; Expression types
(load "4.query.qeval.simple.scm")
(load "4.query.qeval.conjoin.scm")
(load "4.query.qeval.disjunct.scm")
(load "4.query.qeval.negate.scm")
(load "4.query.qeval.lisp-value.scm")
(load "4.query.qeval.always-true.scm")
;; Application types
(load "4.query.apply.binding.frame.scm")
;; Driver
(load "4.query.driver.scm")
(load "4.query.data-base.scm")
(load "4.query.data-base.microshaft.scm")
;; Setup
(define rule-counter 0)
(define THE-RULES the-empty-stream)
(define THE-ASSERTIONS the-empty-stream)
(define *op-table* (make-hash-table))
(install-conjoin-package)
(install-disjunct-package)
(install-negate-package)
(install-lisp-value-package)
(install-always-true-package)
(initialize-data-base microshaft-data-base)
