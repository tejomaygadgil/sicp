;; Inherit
(load "4.mceval.scm")
;; Util
(load "0.table.scm")
;; Core
(load "4.3.mceval.eval.scm")
;; Expression types
(load "4.3.mceval.eval.self-evaluating.scm")
(load "4.3.mceval.eval.variable.scm")
(load "4.3.mceval.eval.quoted.scm")
(load "4.3.mceval.eval.assignment.scm")
(load "4.3.mceval.eval.definition.scm")
(load "4.3.mceval.eval.if.scm")
(load "4.3.mceval.eval.lambda.scm")
(load "4.3.mceval.eval.begin.scm")
(load "4.3.mceval.eval.cond.scm")
(load "4.3.mceval.eval.load.scm")
;; Setup
(define *op-table* (make-hash-table))
(install-self-evaluating-package)
(install-variable-package)
(install-quotation-package)
(install-assignment-package)
(install-definition-package)
(install-if-package)
(install-lambda-package)
(install-begin-package)
(install-cond-package)
(install-load-package)
