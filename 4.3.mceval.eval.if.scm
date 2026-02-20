(define (install-if-package)
  (put 'eval 'if
       (lambda (exp env)
         (if (true? (eval (if-predicate exp) env))
             (eval (if-consequent exp) env)
             (eval (if-alternative exp) env))))
  'ok)

(define (if-predicate exp)
  (cadr exp))

(define (if-consequent exp)
  (caddr exp))

(define (if-alternative exp)
  (if (not (null? (cdddr exp)))
      (cadddr exp)
      'false))

(define (true? x)
  (not (eq? x false)))

(define (false? x)
  (eq? x false))

(define (make-if predicate consequent alternative)
  (list 'if predicate consequent alternative))
