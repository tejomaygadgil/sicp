(define (install-cons)
  (for-each mc-eval
            '((define (cons x y)
                (lambda (m) (m lazy-pair x y)))
              (define (car z)
                (z (lambda (tag p q) p)))
              (define (cdr z)
                (z (lambda (tag p q) q)))
              (define ones (cons 1 ones))
              (define integers (cons 1
                                     (add-lists ones
                                                integers)))
              (define fibs (cons 0
                                 (cons 1
                                       (add-lists (cdr fibs)
                                                  fibs))))))
  'ok)
