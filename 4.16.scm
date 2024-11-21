;;;; 4.16
;; In this exercise we implement the method just described for interpreting internal definitions. We assume that the evaluator supports `let` (see exercise 4.6).
;;
;; a.  Change `lookup-variable-value` (section 4.1.3) to signal an error if the value it finds is the symbol `*unassigned*`.
;;
;; b.  Write a procedure `scan-out-defines` that takes a procedure body and returns an equivalent one that has no internal definitions, by making the transformation described above.
;;
;; c.  Install `scan-out-defines` in the interpreter, either in `make-procedure` or in `procedure-body` (see section 4.1.3). Which place is better? Why?

;;; Answer
;; a. 4.16.metacircular.lookup.scm
;; b. 4.16.metacircular.procedure.scm
;; c. Creating the internal block is a one-time task, so it
;; is better to do it in the constructor than the selector.

;; Test
(load "0.util.scm")
(load "0.table.scm")
(load "4.3.metacircular.application.scm")
(load "4.3.metacircular.self-evaluating.scm")
(load "4.3.metacircular.variable.scm")
(load "4.3.metacircular.quotation.scm")
(load "4.3.metacircular.assignment.scm")
(load "4.16.metacircular.definition.scm") ; Changed
(load "4.3.metacircular.if.scm")
(load "4.3.metacircular.lambda.scm")
(load "4.3.metacircular.begin.scm")
(load "4.4.scm") ; and / or
(load "4.5.scm") ; cond (=>) (shadows 4.3.metacircular.cond.scm)
(load "4.7.scm") ; let*
(load "4.8.scm") ; named let (shadows 4.6.scm)
(define *op-table* (make-hash-table))
(install-self-evaluating-package)
(install-variable-package)
(install-quotation-package)
(install-assignment-package)
(install-definition-package)
(install-if-package)
(install-lambda-package)
(install-begin-package)
(install-cond-package)
(install-and-or-package)
(install-let-package)
(install-let*-package)
;; Components
(load "4.3.metacircular.eval.scm")
(load "4.12.metacircular.frame.scm")
(load "4.12.metacircular.env.scm")
(load "4.16.metacircular.lookup.scm") ; Changed
(load "4.16.metacircular.procedure.scm") ; Changed
(load "4.metacircular.primitive.scm")
(load "4.metacircular.apply.scm")
(load "4.metacircular.global.scm")
;; Test
(define the-global-environment (setup-environment))
(define body1 '((define x 1)
                (+ x y)))
(define scanned1 (list '(let ((x *unassigned*))
                          (set! x 1)
                          (+ x y))))
(define body2 '((define (odd? n)
                  (if (= n 0) true
                    (even? (- n 1))))
                (define (even? n)
                  (if (= n 0) true
                    (odd? (- n 1))))
                (odd? 11)))
(define scanned2 (list '(let ((even? *unassigned*)
                              (odd? *unassigned*))
                          (set! even? (lambda (n) (if (= n 0) true (odd? (- n 1)))))
                          (set! odd? (lambda (n) (if (= n 0) true (even? (- n 1)))))
                          (odd? 11))))
(test (scan-out-defines body1) scanned1)
(test (scan-out-defines body2) scanned2)
(print (eval '(let ((a 1)) ; Ex 4.19
                (define (f x)
                  (define b (+ a x))
                  (define a 5)
                  (+ a b))
                (f 10))
             the-global-environment))
