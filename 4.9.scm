;;;; 4.9
;; Many languages support a variety of iteration constructs, such as `do`, `for`, `while`, and `until.` In Scheme, iterative processes can be expressed in terms of ordinary procedure calls, so special iteration constructs provide no essential gain in computational power. On the other hand, such constructs are often convenient. Design some iteration constructs, give examples of their use, and show how to implement them as derived expressions.

;;; Answer
(define (install-do-while-package)
  ;; Cons
  (define (make-named-let name defs body)
    (list 'let name defs body))
  ;; Sel
  (define (do-while-proc exp)
    (cadr exp))
  (define (do-while-cond exp)
    (cadddr exp))
  ;; Proc
  (define (do-while->let exp)
    (make-named-let 'iter
                    '()
                    (make-if (do-while-cond exp)
                             (make-begin (list (do-while-proc exp)
                                               (list 'iter)))
                             '())))
  ;; Install
  (put 'eval 'do (lambda (exp env) (eval (do-while->let exp) env)))
  'ok)
