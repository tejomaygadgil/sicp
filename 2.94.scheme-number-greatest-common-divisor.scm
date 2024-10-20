(define (install-scheme-number-greatest-common-divisor-package)
  ;; Install
  (define (tag x) (attach-tag 'scheme-number x))
  (put 'greatest-common-divisor '(scheme-number scheme-number)
       (lambda (x y)
         (tag (gcd x y))))
  'done)
