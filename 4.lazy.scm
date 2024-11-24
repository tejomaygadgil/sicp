;; Interface
(load "4.lazy.thunk.scm") ; Added
(load "4.metacircular.procedure.scm")
(load "4.lazy.application.scm")
(load "4.12.metacircular.frame.scm")
(load "4.12.metacircular.env.scm")
(load "4.12.metacircular.lookup.scm")
;;  Core
(load "4.lazy.eval.scm") ; Changed
(load "4.lazy.apply.scm") ; Changed
;; Setup
(load "4.metacircular.primitive.scm")
(load "4.metacircular.global.scm")
(load "4.lazy.driver.scm") ; Changed
(load "4.metacircular.extras.scm")
(load "4.lazy.util.scm") ; Changed
;; Packages
(load "0.table.scm")
(load "4.3.metacircular.self-evaluating.scm")
(load "4.3.metacircular.variable.scm")
(load "4.3.metacircular.quotation.scm")
(load "4.3.metacircular.assignment.scm")
(load "4.3.metacircular.definition.scm")
(load "4.lazy.if.scm") ; Changed
(load "4.3.metacircular.lambda.scm")
(load "4.3.metacircular.begin.scm")
(load "4.4.scm") ; and / or
(load "4.5.scm") ; cond (=>) (shadows 4.3.metacircular.cond.scm)
(load "4.7.scm") ; let*
(load "4.8.scm") ; named let (shadows 4.6.scm)
(load "4.20.a.scm") ; letrec
(load "4.metacircular.load.scm")
;; Install
(define the-global-environment (setup-environment))
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
(install-and-or-package)
(install-let-package)
(install-let*-package)
(install-letrec)
(install-load-package)
(install-extras)
