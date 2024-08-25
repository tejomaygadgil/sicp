;;;; 1.11
;; A function f is defined by the rule that f(n) = n if n < 3 and f(n) = f(n - 1) + 2 * f(n - 2) + 3 * f(n - 3) if n > 3. Write a procedure that computes f by means of a recursive process. Write a procedure that computes f by means of an iterative process.

;;; Answwer
(define (f-rec n)
  (if (< n 3) n
    (+ (f-rec (- n 1))
       (* 2 (f-rec (- n 2)))
       (* 3 (f-rec (- n 3))))))

(define (f-iter n)
  (define (iter a b c i n)
    (if (> i n) a
      (iter (+ a (* 2 b) (* 3 c)) a b (+ i 1) n)))
  (iter 2 1 0 0 (- n 3)))
