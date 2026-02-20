(define (install-let-package)
  (put 'eval 'let
       (lambda (exp env)
         (eval (let->combination exp) env)))
  'ok)

(define (let-name exp)
  (if (symbol? (cadr exp))
      (cadr exp)
      false))

(define (let-defs exp)
  (if (let-name exp)
      (caddr exp)
      (cadr exp)))

(define (let-body exp)
  (if (let-name exp)
      (cdddr exp)
      (cddr exp)))

(define (let-args exp)
  (map car (let-defs exp)))

(define (let-vals exp)
  (map cadr (let-defs exp)))

(define (let->combination exp)
  (if (let-name exp)
      (let ((name (let-name exp))
            (args (let-args exp))
            (vals (let-vals exp))
            (body (let-body exp)))
        (make-begin
         (list (make-definition (cons name args)
                                (make-begin body))
               (cons name vals))))
      (cons (make-lambda (let-args exp)
                         (let-body exp))
            (let-vals exp))))

(define (make-let defs body)
  (cons 'let (cons defs body)))

(define (make-named-let name defs body)
  (list 'let name defs body))
