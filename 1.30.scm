;;;; 1.30
;; The `sum` procedure above generates a linear recursion. The procedure can be rewritten so that the sum is performed iteratively. Show how to do this by filling in the missing expressions in the following definition:
;;
;; (define (sum term a next b)
;;   (define (iter a result)
;;     (if <??>
;;         <??>
;;         (iter <??> <??>)))
;;   (iter <??> <??>))

;;; Answer
(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ result (term a)))))
  (iter a 0))

;; Test
(load "0.util.scm")
(test (sum (lambda (x) x)
           1
           (lambda (x) (+ 1 x))
           10)
      55)
