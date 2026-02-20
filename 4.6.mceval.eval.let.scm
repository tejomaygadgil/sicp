(define (install-let-package)
  (put 'eval 'let
       (lambda (exp env)
         (eval (let->combination exp) env)))
  'ok)

(define (let-defs exp)
  (cadr exp))

(define (let-body exp)
  (cddr exp))

(define (let-args exp)
  (map car (let-defs exp)))

(define (let-vals exp)
  (map cadr (let-defs exp)))

(define (let->combination exp)
  (cons (make-lambda (let-args exp)
                     (let-body exp))
        (let-vals exp)))

(define (make-let defs body)
  (cons 'let (cons defs body)))
