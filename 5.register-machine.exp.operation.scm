;; Cons
(define (make-operation-exp exp machine labels ops)
  (define (lookup-prim symbol ops)
    (let ((val (assoc symbol ops)))
      (if val
          (cadr val)
          (error "Unknown operation -- ASSEMBLE" symbol))))
  (let ((op (lookup-prim (operation-exp-op exp) ops))
        (aprocs
          (map (lambda (e)
                 (make-primitive-exp e machine labels))
               (operation-exp-operands exp))))
    (lambda ()
      (apply op (map (lambda (p) (p)) aprocs)))))
;; Sel
(define (operation-exp-op operation-exp)
  (cadr (car operation-exp)))
(define (operation-exp-operands operation-exp)
  (cdr operation-exp))
;; Pred
(define (operation-exp? exp)
  (and (pair? exp) (tagged-list? (car exp) 'op)))
