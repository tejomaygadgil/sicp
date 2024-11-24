(define (install-cons-package)
  (map global-eval
       '((define (cons x y)
           (lambda (m) (m lazy-pair x y)))
         (define (car z)
           (z (lambda (tag p q) p)))
         (define (cdr z)
           (z (lambda (tag p q) q)))))
  'ok)
