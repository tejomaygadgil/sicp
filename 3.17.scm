;;;; 3.17
;; Devise a correct version of the `count-pairs` procedure of exercise 3.16 that returns the number of distinct pairs in any structure. (Hint: Traverse the structure, maintaining an auxiliary data structure that is used to keep track of which pairs have already been counted.)

;;; Answer
(define (count-pairs x)
  (let ((cache '()))
    (let iter ((x x))
      (if (not (pair? x)) 0
        (+ (iter (car x))
           (iter (cdr x))
           (if (memq x cache) 0
             (begin
               (set! cache (cons x cache))
               1)))))))

;; Test
(load "0.util.scm")
(define count-4 (cons (cons (cons 'a '()) 'b) '()))
(set-cdr! count-4 (caar count-4))
(define count-7 (cons (cons (cons 'a '()) '()) '()))
(set-cdr! count-7 (car count-7))
(set-cdr! (car count-7) (caar count-7))
(test (count-pairs count-4) 3)
(test (count-pairs count-7) 3)
