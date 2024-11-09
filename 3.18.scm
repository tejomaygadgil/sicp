;;;; 3.18
;; Write a procedure that examines a list and determines whether it contains a cycle, that is, whether a program that tried to find the end of the list by taking successive `cdr`s would go into an infinite loop. Exercise 3.13 constructed such lists.

;;; Answer
(define (contains-cycle x)
  (let ((cache '()))
    (let inner ((x x))
      (if (not (pair? x)) false
        (let ((first (car x))
              (rest (cdr x)))
          (if (memq first cache) true
            (begin
              (set! cache (cons first cache))
              (inner rest))))))))

;; Test
(load "0.util.scm")
(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)
(define l1 (list 'a 'b 'c))
(define l2 (make-cycle (list 'a 'b 'c)))
(test (contains-cycle l1) false)
(test (contains-cycle l2) true)
