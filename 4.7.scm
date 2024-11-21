;;;; 4.7
;; `Let*` is similar to `let`, except that the bindings of the `let` variables are performed sequentially from left to right, and each binding is made in an environment in which all of the preceding bindings are visible. For example
;;
;; (let* ((x 3)
;;        (y (+ x 2))
;;        (z (+ x y 5)))
;;   (* x z))
;;
;; returns 39. Explain how a `let*` expression can be rewritten as a set of nested `let` expressions, and write a procedure `let*->nested-lets` that performs this transformation. If we have already implemented `let` (exercise 4.6) and we want to extend the evaluator to handle `let*`, is it sufficient to add a clause to `eval` whose action is
;;
;; (eval (let*->nested-lets exp) env)
;;
;; or must we explicitly expand `let*` in terms of non-derived expressions?

;;; Answer
(define (install-let*-package)
  ;; Proc
  (define (let*->nested-lets exp)
    (define (inner exp)
      (let ((defs (car exp))
            (body (cadr exp)))
        (if (null? defs) body
          (let ((first-def (car defs))
                (rest-defs (cdr defs)))
            (let->combination
              (make-let (list first-def)
                        (list (inner (list rest-defs body)))))))))
    (inner (cdr exp)))
  ;; Install
  (put 'eval 'let* (lambda (exp env) (eval (let*->nested-lets exp) env)))
  'ok)

;; We just showed how to derive `let*` from nested `let` statements.
;; No explicit expansion is needed to add `let*` to the evaluator.
