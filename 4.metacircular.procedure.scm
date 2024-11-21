;; Tagged list
(define (tagged-list? exp tag)
  (and (pair? exp)
       (eq? (car exp) tag)))

;; Aletheia
(define (true? exp) (not (false? exp)))
(define (false? exp) (eq? exp false))

;; Primitive
;; Sel
(define (primitive-implementation proc) (cadr proc))
;; Pred
(define (primitive-procedure? proc)
  (tagged-list? proc 'primitive))
;; Proc
(define apply-in-underlying-scheme apply) ; SICP p. 382
(define (apply-primitive-procedure proc args)
  (apply-in-underlying-scheme
   (primitive-implementation proc) args))

;; Compound
;; Cons
(define (make-procedure parameters body env)
  (list 'procedure parameters body env))
;; Sel
(define (procedure-parameters p) (cadr p))
(define (procedure-body p) (caddr p))
(define (procedure-environment p) (cadddr p))
;; Pred
(define (compound-procedure? p)
  (tagged-list? p 'procedure))
