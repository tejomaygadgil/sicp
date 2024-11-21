;;;; 4.6
;; `Let` expressions are derived expressions, because

;; (let ((<var1> <exp1>) ... (<varn> <expn>))
;;   <body>)
;;
;; is equivalent to
;;
;; ((lambda (<var1> ... <varn>)
;;    <body>)
;;  <exp1>
;;  <expn>)

;; Implement a syntactic transformation `let->combination` that reduces evaluating `let` expressions to evaluating combinations of the type shown above, and add the appropriate clause to `eval` to handle `let` expressions.

;;; Answer
(define (install-let-package)
  ;; Cons
  (define (make-let defs body)
    (cons 'let (cons defs body)))
  ;; Sel
  (define (let-defs exp) (cadr exp))
  (define (let-body exp) (cddr exp))
  (define (let-args exp) (map car (let-defs exp)))
  (define (let-vals exp) (map cadr (let-defs exp)))
  ;; Proc
  (define (let->combination exp)
    (cons (make-lambda (let-args exp) (let-body exp))
          (let-vals exp)))
  ;; Install
  (put 'make 'let make-let)
  (put 'eval 'let (lambda (exp env) (eval (let->combination exp) env)))
  'ok)
;; Interface
(define (make-let defs body)
  ((get 'make 'let) defs body))
