;;;; 4.53
;; With `permanent-set!` as described in exercise 4.51 and `if-fail` as in exercise 4.52, what will be the result of evaluating
;;
;; (let ((pairs '()))
;;   (if-fail (let ((p (prime-sum-pair '(1 3 5 8) '(20 35 110))))
;;              (permanent-set! pairs (cons p pairs))
;;              (amb))
;;            pairs))
;;

;;; Answer
;; The expression accumulates all prime pair sums:
(load "4.amb.scm")
(load "4.51.permanent-set!.scm")
(load "4.52.if-fail.scm")
(install-permanent-set!-package)
(install-if-fail-package)
(global-eval '(load "4.amb.example.prime-pairs.scm"))
(print-amb '(let ((pairs '()))
              (if-fail (let ((p (prime-sum-pair '(1 3 5 8) '(20 35 110))))
                         (permanent-set! pairs (cons p pairs))
                         (amb))
                       pairs)))
