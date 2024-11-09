;;;; 3.19
;; Redo exercise 3.18 using an algorithm that takes only a constant amount of space. (This requires a very clever idea.)

;; https://en.wikipedia.org/wiki/Cycle_detection#Floyd's_tortoise_and_hare
(define (floyd-cycle x)
  (let ((tortoise x)
        (hare x))
    (let iter ()
      (if (or (not (pair? tortoise))
              (not (pair? hare))
              (not (pair? (cdr hare)))) false
        (begin
          (set! tortoise (cdr tortoise))
          (set! hare (cddr hare))
          (if (eq? tortoise hare) true
            (iter)))))))

;; Test
(load "0.util.scm")
(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)
(define l1 (list 'a 'b 'c))
(define l2 (make-cycle (list 'a 'b 'c)))
(test (floyd-cycle l1) false)
(test (floyd-cycle l2) true)
