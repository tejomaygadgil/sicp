(define (install-polynomial-subtract-package)
  ;; Install
  (define (tag p) (attach-tag 'polynomial p))
  (put 'sub '(polynomial polynomial)
       (lambda (p1 p2)
         (add (tag p1)
              (negate (tag p2)))))
  'done)
