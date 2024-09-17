;;;; 2.27
;; Modify your reverse procedure of exercise 2.18 to produce a deep-reverse procedure that takes a list as argument and returns as its value the list with its elements reversed and with all sublists deep-reversed as well. For example,
;;
;; (define x (list (list 1 2) (list 3 4)))
;;
;; x
;; ((1 2) (3 4))
;;
;; (reverse x)
;; ((3 4) (1 2))
;;
;; (deep-reverse x)
;; ((4 3) (2 1))

;;; Answer
(define (deep-reverse items)
  (if (null? items) items
    (append (deep-reverse (cdr items))
            (list (if (pair? (car items)) (deep-reverse (car items)) (car items))))))

;; Test
(load "0.util.scm")
(test (deep-reverse (list 1 2 3 4)) (list 4 3 2 1))
(test (deep-reverse (list 1 (list 2 (list 5 3)) 4)) '(4 ((3 5) 2) 1))
