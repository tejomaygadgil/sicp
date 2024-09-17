;;;; 2.18
;; Define a procedure reverse that takes a list as argument and returns a list of the same elements in reverse order:
;;
;; (reverse (list 1 4 9 16 25))
;; (25 16 9 4 1)

;;; Answer
(define (reverse l)
  (if (null? l) l
    (append (reverse (cdr l))
            (list (car l)))))

;; Test
(load "0.util.scm")
(test (reverse (list 1 2 3 4)) (list 4 3 2 1))
