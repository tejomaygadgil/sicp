;; Inherit
(load "4.query.scm")
;; Expression types
(load "4.77.query.qeval.negate.scm")
(load "4.77.query.qeval.lisp-value.scm")
;; Application types
(load "4.77.query.apply.frames.scm")
;; Setup
(install-negate-package)
(install-lisp-value-package)
