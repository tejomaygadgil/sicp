;;;; 2.89
;; Define procedures that implement the term-list representation described above as appropriate for dense polynomials.

;;; Answer
(load "2.term.scm") ; order, coeff, make-term
(load "2.termlist-sparse.scm")
;; Sel
(define (degree term-list)
  (- (length term-list) 1))
(define (first-term term-list)
  (make-term (degree term-list)
             (car term-list)))
;; Proc
(define (adjoin-term term term-list)
  (let ((term-order (order term))
        (term-list-degree (degree term-list)))
    (if (> term-order term-list-degree)
      (let iter ((pad (- term-order term-list-degree 1))
                 (acc term-list))
        (if (zero? pad)
          (cons (coeff term) acc)
          (iter (- pad 1) (cons 0 acc))))
      (error "order not greater than degree -- ADJOIN-TERM" term-order term-list-degree))))

;; Test
(load "0.util.scm")
(define x '(1 2 0 3 4 5))
(define y (make-term 10 4))
(define z (make-term 3 4))
(test (first-term x) '(5 1))
(test (adjoin-term y x) (append '(4 0 0 0 0) x))
;; (print (adjoin-term z x)) ; Fail case
