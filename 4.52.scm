;;;; 4.52
;; Implement a new construct called `if-fail` that permits the user to catch the failure of an expression. `If-fail` takes two expressions. It evaluates the first expression as usual and returns as usual if the evaluation succeeds. If the evaluation fails, however, the value of the second expression is returned, as in the following example:
;;
;; ;;; Amb-Eval input:
;; (if-fail (let ((x (an-element-of '(1 3 5))))
;;            (require (even? x))
;;            x)
;;          'all-odd)
;; ;;; Starting a new problem
;; ;;; Amb-Eval value:
;; all-odd
;; ;;; Amb-Eval input:
;; (if-fail (let ((x (an-element-of '(1 3 5 8))))
;;            (require (even? x))
;;            x)
;;          'all-odd)
;; ;;; Starting a new problem
;; ;;; Amb-Eval value:
;; 8

;; Test
(load "4.amb.scm")
(load "4.52.if-fail.scm")
(install-if-fail-package)
(global-eval '(define (even? x) (= (remainder x 2) 0)))
(test-global-eval '(if-fail (let ((x (an-element-of '(1 3 5))))
                              (require (even? x))
                              x)
                            'all-odd)
                  'all-odd)
(test-global-eval '(if-fail (let ((x (an-element-of '(1 3 5 8))))
                              (require (even? x))
                              x)
                            'all-odd)
                  8)
