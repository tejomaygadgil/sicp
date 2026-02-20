;; Util
(load "0.util.scm")
;; Core
(load "4.mceval.eval.scm")
(load "4.mceval.apply.scm")
;; Expression types
(load "4.mceval.eval.self-evaluating.scm")
(load "4.mceval.eval.variable.scm")
(load "4.mceval.eval.quoted.scm")
(load "4.mceval.eval.assignment.scm")
(load "4.mceval.eval.definition.scm")
(load "4.mceval.eval.if.scm")
(load "4.mceval.eval.lambda.scm")
(load "4.mceval.eval.begin.scm")
(load "4.mceval.eval.cond.scm")
(load "4.mceval.eval.application.scm")
;; Application types
(load "4.mceval.apply.env.scm")
(load "4.mceval.apply.frame.scm")
(load "4.mceval.apply.primitive.scm")
(load "4.mceval.apply.compound.scm")
;; Driver
(load "4.mceval.setup.scm")
(load "4.mceval.extra.scm")
(load "4.mceval.driver.scm")
;; Setup
(define the-global-environment (setup-environment))
(install-extras)
