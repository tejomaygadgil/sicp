(define (install-symbolic-real-number-package)
  ;;; Install
  (define (tag x)
    (attach-tag 'real-number x))
  (put 'add '(real-number real-number)
       (lambda (x y) (tag (+ x y))))
  (put 'sub '(real-number real-number)
       (lambda (x y) (tag (- x y))))
  (put 'mul '(real-number real-number)
       (lambda (x y) (tag (* x y))))
  (put 'div '(real-number real-number)
       (lambda (x y) (tag (/ x y))))
  (put 'make 'real-number
       (lambda (x) (tag (inexact x))))
  'done)
;; Cons
(define (make-real-number n)
  ((get 'make 'real-number) n))
;; Pred
(define (real-number? n)
  (equal? (type-tag n) 'real-number))
