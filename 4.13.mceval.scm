;; Inherit
(load "4.12.mceval.scm")
;; Expression types
(load "4.13.mceval.eval.make-unbound.scm")
;; Application types
(load "4.13.mceval.apply.frame.scm")
(load "4.13.mceval.apply.env.scm")
;; Setup
(define the-global-environment (setup-environment))
(install-make-unbound-package)
