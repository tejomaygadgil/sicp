;;;; 2.84
;; Using the raise operation of exercise 2.83, modify the `apply-generic` procedure so that it coerces its arguments to have the same type by the method of successive raising, as discussed in this section. You will need to devise a way to test which of two types is higher in the tower. Do this in a manner that is "compatible" with the rest of the system and will not lead to problems in adding new levels to the tower.

;;; Answer
(define (apply-generic op . args)
  (define (raise-to source target)
    (let ((target-type (type-tag target)))
      (let iter ((source source))
        (let ((raised (raise source)))
          (if (false? raised) false ; Fail case
            (let ((raised-type (type-tag raised)))
            (cond ((equal? raised-type target-type) raised) ; Base case
                  (raised (iter raised))))))))) ; Reduction step
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
        (apply proc (map contents args)) ; Base case
        (if (= (length args) 2)
          (let ((arg1 (car args))
                (arg2 (cadr args)))
            (let ((raise1 (raise-to arg1 arg2)))
              (if raise1 (apply-generic op raise1 arg2) ; Reduce left
                (let ((raise2 (raise-to arg2 arg1)))
                  (apply-generic op arg1 raise2))))) ; Reduce right
          false))))) ; Fail case

;; Test
(load "0.util.scm")
(load "0.table.scm")
(load "2.symbolic-tagged-data.scm")
(load "2.symbolic-interface.scm")
(define *op-table* (make-hash-table))
(load "2.symbolic-scheme-number.scm")
(load "2.symbolic-rational.scm")
(load "2.symbolic-real-number.scm")
(load "2.symbolic-complex.scm")
(install-symbolic-scheme-number-package)
(install-symbolic-rational-package)
(install-symbolic-real-number-package)
(install-symbolic-complex-package)
(load "2.complex-rectangular.scm")
(load "2.complex-polar.scm")
(install-complex-rectangular-package)
(install-complex-polar-package)
(load "2.83.symbolic-raise.scm")
(install-symbolic-raise-package)
;; Test
(test (add 5 (make-rational 5 6)) (make-rational 35 6))
(test (add (make-rational 5 6) 5) (make-rational 35 6))
(test (mul (make-rational 15 6) 0.4) 1.0)
(test (mul 0.4 (make-rational 15 6)) 1.0)
