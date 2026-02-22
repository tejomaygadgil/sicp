(define (install-quotation-package)
  (put 'eval 'quote
       (lambda (exp env)
         (text-of-quotation exp env)))
  'ok)

(define (text-of-quotation exp env)
  (let ((text (cadr exp)))
    (if (pair? text)
        (eval (quote->cons text) env)
        text)))

(define (quote->cons exp)
  (let iter ((exp exp))
    (if (null? exp) '()
        (list 'cons (list 'quote (car exp))
              (iter (cdr exp))))))
