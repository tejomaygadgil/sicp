(define (install-cons)
  (for-each mc-eval
            '((define (cons x y)
                (lambda (m) (m x y)))
              (define (car z)
                (z (lambda (p q) p)))
              (define (cdr z)
                (z (lambda (p q) q)))
              (define (scale-list items factor)
                (map (lambda (x) (* x factor))
                     items))
              (define (add-lists list1 list2)
                (cond ((null? list1) list2)
                      ((null? list2) list1)
                      (else (cons (+ (car list1) (car list2))
                                  (add-lists (cdr list1) (cdr list2))))))
              (define ones (cons 1 ones))
              (define integers (cons 1
                                     (add-lists ones
                                                integers)))
              (define fibs (cons 0
                                 (cons 1
                                       (add-lists (cdr fibs)
                                                  fibs))))))
  'ok)
