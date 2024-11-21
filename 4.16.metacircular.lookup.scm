(load "4.12.metacircular.env.scm")
(load "4.12.metacircular.frame.scm")
(load "4.12.metacircular.lookup.scm")

(define (lookup-variable-value var env)
  (let ((result (scan-env var env)))
    (if result
      (let ((unassigned? (lambda (val) (eq? val '*unassigned*)))
            (val (cadr result)))
        (if (unassigned? val)
          (error "Unnassigned variable -- LOOKUP-VARIABLE-VALUE" var)
          val))
      (error "Unbound variable -- LOOKUP-VARIABLE-VALUE" var))))
