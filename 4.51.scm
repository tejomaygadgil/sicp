;;;; 4.51
;; Implement a new kind of assignment called `permanent-set!` that is not undone upon failure. For example, we can choose two distinct elements from a list and count the number of trials required to make a successful choice as follows:
;;
;; (define count 0)
;; (let ((x (an-element-of '(a b c)))
;;       (y (an-element-of '(a b c))))
;;   (permanent-set! count (+ count 1))
;;   (require (not (eq? x y)))
;;   (list x y count))
;; ;;; Starting a new problem
;; ;;; Amb-Eval value:
;; (a b 2)
;; ;;; Amb-Eval input:
;; try-again
;; ;;; Amb-Eval value:
;; (a c 3)
;;
;; What values would have been displayed if we had used `set!` here rather than `permanent-set!` ?


;;; Answer
;; `set!` would reset `x` to 0, resulting
;; in 1 being printed for each iteration.

;; Test
(load "4.amb.scm")
(load "4.51.permanent-set!.scm")
(install-permanent-set!-package)
(global-eval '(define count 0))
(print-amb '(let ((x (an-element-of '(a b c)))
                  (y (an-element-of '(a b c))))
              (permanent-set! count (+ count 1))
              (require (not (eq? x y)))
              (list x y count)))
