;; Inherit
(load "4.12.mceval.scm")
;; Core
(load "4.leval.eval.scm")
(load "4.leval.apply.scm")
(load "4.leval.thunk.scm")
;; Expression types
(load "4.leval.eval.if.scm")
(load "4.leval.eval.application.scm")
;; Driver
(load "4.leval.driver.scm")
(load "4.leval.extra.scm")
;; Setup
(install-if-package)
(install-extras)
