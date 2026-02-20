;; Inherit
(load "4.8.mceval.scm")
;; Application types
(load "4.11.mceval.apply.frame.scm")
(load "4.12.mceval.apply.env.scm")
;; Setup
(define the-global-environment (setup-environment))
