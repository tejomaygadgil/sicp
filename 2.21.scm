;;;; 2.21
;; The procedure `square-list` takes a list of numbers as argument and returns a list of the squares of those numbers.
;;
;; (square-list (list 1 2 3 4))
;; (1 4 9 16)
;;
;; Here are two different definitions of `square-list.` Complete both of them by filling in the missing expressions:
;;
;; (define (square-list items)
;;   (if (null? items)
;;       nil
;;       (cons <??> <??>)))
;; (define (square-list items)
;;   (map <??> <??>))

;;; Answer
(define (square-list items)
  (if (null? items)
      ()
      (cons (expt (car items) 2)
            (square-list (cdr items)))))

(define (square-list items)
  (map (lambda (x) (expt x 2)) items))

;; The second `square-list` separates the transformation from the means of iteration.
