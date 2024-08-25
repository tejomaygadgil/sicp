;;;; 1,31
;; a.  The `sum` procedure is only the simplest of a vast number of similar abstractions that can be captured as higher-order procedures. Write an analogous procedure called `product` that returns the product of the values of a function at points over a given range. Show how to define `factorial` in terms of `product`. Also use `product` to compute approximations to $\pi$ using the formula
;;
;; pi / 4 = (2 * 4 * 4 * 6 * 6 * 8 ...) / (3 * 3 * 5 * 7 * 7 ...)
;;
;; b.  If your product procedure generates a recursive process, write one that generates an iterative process. If it generates an iterative process, write one that generates a recursive process.

;;; Answer
;; a. recursive `product`
(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))

(define (id x) x)
(define (1+ x) (+ x 1))

(define (factorial n)
  (product id 1 1+ n))

(define (wallis-pi n)
  (define (wallis-term i)
    (/ (+ 2 (* (floor (/ (+ i 1) 2)) 2))
       (+ 3 (* (floor (/ i 2)) 2))))
  (/ (product wallis-term 0 1+ (- n 1))
     1.0))

;; Test
(define (display-pi)
  (display (* 4 (wallis-pi 10000)))
  (newline))
(display-pi)

; b. recursion --> iteration
(define (product term a next b)
  (display "Using iterative product:")
  (newline)
  (define (iter a p)
    (if (> a b)
        p
        (iter (next a) (* p (term a)))))
  (iter a 1))

;; Test
(display-pi)
