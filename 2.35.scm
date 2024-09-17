;;;; 2.35
;; Redefine `count-leaves` from section 2.2.2 as an accumulation:
;;
;; (define (count-leaves t)
;;   (accumulate <??> <??> (map <??> <??>)))

;;; Answer
(load "0.efma.scm")
(define (count-leaves t)
  (accumulate +
              0
              (map (lambda (t) 1) (enumerate-tree t))))

;; Test
(load "0.util.scm")
(define a (list (list 1 2) (list 3 4)))
(define b (list 1 (list 2 (list 4 5)) (list 2 3)))
(test (count-leaves a) 4)
(test (count-leaves b) 6)
