(define (install-map-lists-package)
  (map global-eval
    '((define (map-lists proc list1 list2)
        (cond ((null? list1) list2)
              ((null? list2) list1)
              (else (cons (proc (car list1) (car list2))
                          (map-lists proc
                                     (cdr list1) (cdr list2))))))
      (define (add-lists list1 list2)
        (map-lists + list1 list2))
      (define (sub-lists list1 list2)
        (map-lists - list1 list2))
      (define (mul-lists list1 list2)
        (map-lists * list1 list2))
      (define (div-lists list1 list2)
        (map-lists / list1 list2))
      (define (scale-list items factor)
        (map (lambda (x) (* x factor)) items))))
  'ok)
