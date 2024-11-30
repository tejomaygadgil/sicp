;; Cons
(define (make-new-variable var rule-application-id)
  (cons '? (cons rule-application-id (cdr var))))
;; Proc
(define (rename-variables-in rule)
  (let ((rule-application-id (new-rule-application-id)))
    (define (tree-walk exp)
      (cond ((var? exp)
             (make-new-variable exp rule-application-id))
            ((pair? exp)
             (cons (tree-walk (car exp))
                   (tree-walk (cdr exp))))
            (else exp)))
    (tree-walk rule)))
;; Mut
(define (new-rule-application-id)
  (set! rule-counter (+ 1 rule-counter))
  rule-counter)
