;;;; 2.82
;; Show how to generalize `apply-generic` to handle coercion in the general case of multiple arguments. One strategy is to attempt to coerce all the arguments to the type of the first argument, then to the type of the second argument, and so on. Give an example of a situation where this strategy (and likewise the two-argument version given above) is not sufficiently general. (Hint: Consider the case where there are some suitable mixed-type operations present in the table that will not be tried.)

;;; Answer
;; This technique will not work if A and B are both convertible to some third type C. (Question: what mathematical property is this?)
(define (apply-generic op . args)
  (define (coerce-to type args)
    (let iter ((args args)
               (acc '()))
      (if (null? args) acc ; Return (base case)
        (let* ((first (car args))
               (first-type (type-tag first))
               (coerce-proc (get first-type type))
               (rest (cdr args)))
          (cond ((equal? type first-type)
                 (iter rest
                       (append acc
                               (list first)))) ; Append if same type (reduction)
                (coerce-proc
                  (iter rest
                        (append acc
                                (list (coerce-proc first))))) ; Coerce if coercible (reduction)
                (else false)))))) ; Otherwise return false (fail case)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
        (apply proc (map contents args))
        (let ((coerced-args (let iter ((targets args)) ; Try coercing on every arg
                              (if (null? targets) false
                                (let ((plan (coerce-to (type-tag (car targets)) args)))
                                  (if plan plan
                                    (iter (cdr targets))))))))
          (if coerced-args
            (fold (lambda (x acc) (apply-generic op acc x)) ; Fold args if they exist
                  (car coerced-args)
                  (cdr coerced-args))
            (error "No coercion plan found -- APPLY-GENERIC" op args))))))) ; Error out otherwise

;; Test
(load "0.util.scm")
(load "0.table.scm")
(load "2.78.scm") ; Scheme-number tagged data
(load "2.symbolic-interface.scm")
(define *op-table* (make-hash-table))
(load "2.symbolic-scheme-number.scm")
(load "2.symbolic-rational.scm")
(load "2.symbolic-complex.scm")
(install-symbolic-scheme-number-package)
(install-symbolic-rational-package)
(install-symbolic-complex-package)
(load "2.complex-rectangular.scm")
(load "2.complex-polar.scm")
(install-complex-rectangular-package)
(install-complex-polar-package)
;; Install package
(define (install-symbolic-coercion-package)
  (define (scheme-number->complex n)
    (make-complex-from-real-imag (contents n) 0))
  (put 'scheme-number 'complex scheme-number->complex)
  'done)
(install-symbolic-coercion-package)
;; Test
(test (apply-generic 'add 1
                          2
                          3)
      6)
(test (apply-generic 'add (make-rational 1 2)
                          (make-rational 3 4)
                          (make-rational 6 7))
      (make-rational 59 28))
(test (apply-generic 'add 1
                          2
                          (make-complex-from-real-imag 1 2))
      (make-complex-from-real-imag 4 2))
;; (test (apply-generic 'add 1
;;                           (make-rational 3 4)
;;                           3)
;;       false) ; Fail case
