;; Core
(load "4.query.qeval.scm")
(load "4.78.query.apply.scm")
;; Expression types
(load "4.78.query.qeval.simple.scm")
(load "4.query.qeval.conjoin.scm")
(load "4.78.query.qeval.disjunct.scm")
(load "4.78.query.qeval.negate.scm")
(load "4.78.query.qeval.lisp-value.scm")
(load "4.query.qeval.always-true.scm")
;; Application types
(load "4.query.apply.binding.frame.scm")
;; Driver
(load "4.78.query.driver.scm")
(load "4.78.query.data-base.scm")
(load "4.query.data-base.microshaft.scm")
;; Setup
(define rule-counter 0)
(define THE-RULES '())
(define THE-ASSERTIONS '())
(install-conjoin-package)
(install-disjunct-package)
(install-negate-package)
(install-lisp-value-package)
(install-always-true-package)
;; (initialize-data-base microshaft-data-base) ;; Fails when evaluated outside of driver loop (?)
