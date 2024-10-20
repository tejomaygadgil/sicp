(define (install-symbolic-rational-package)
  ;; Representation
  (include "2.93.rational.scm") ; (*)
  ;; internal procedures
  (define (add-rat x y)
    (make-rat (add (mul (numer x) (denom y)) ; (*)
                 (mul (numer y) (denom x))) ; (*)
              (mul (denom x) (denom y)))) ; (*)
  (define (sub-rat x y)
    (make-rat (sub (mul (numer x) (denom y)) ; (*)
                 (mul (numer y) (denom x))) ; (*)
              (mul (denom x) (denom y)))) ; (*)
  (define (mul-rat x y)
    (make-rat (mul (numer x) (numer y)) ; (*)
              (mul (denom x) (denom y)))) ; (*)
  (define (div-rat x y)
    (make-rat (mul (numer x) (denom y)) ; (*)
              (mul (denom x) (numer y)))) ; (*)
  ;; interface to rest of the system
  (define (tag x) (attach-tag 'rational x))
  (put 'add '(rational rational)
       (lambda (x y) (tag (add-rat x y))))
  (put 'sub '(rational rational)
       (lambda (x y) (tag (sub-rat x y))))
  (put 'mul '(rational rational)
       (lambda (x y) (tag (mul-rat x y))))
  (put 'div '(rational rational)
       (lambda (x y) (tag (div-rat x y))))
  (put 'make 'rational
       (lambda (n d) (tag (make-rat n d))))
  'done)
;; Cons
(define (make-rational n d)
  ((get 'make 'rational) n d))
;; Pred
(define (rational? n)
  (equal? (type-tag n) 'rational))
