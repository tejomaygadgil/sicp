;;;; 4.36
;; Exercise 3.69 discussed how to generate the stream of all Pythagorean triples, with no upper bound on the size of the integers to be searched. Explain why simply replacing `an-integer-between` by `an-integer-starting-from` in the procedure in exercise 4.35 is not an adequate way to generate arbitrary Pythagorean triples. Write a procedure that actually will accomplish this. (That is, write a procedure for which repeatedly typing `try-again` would in principle eventually generate all Pythagorean triples.)

;;; Answer
;; The procedure will get stuck backtracking `k`
;; to find a Pythagorean triple for $i = 1$ and $j = 2$.

;; Test
(load "4.amb.scm")
(load "4.35.an-integer-between.scm")
(install-an-integer-between)
(global-eval
  '(define (all-pythagorean-triples)
     (let ((k (an-integer-starting-from 1)))
       (let ((j (an-integer-between 1 k)))
         (let ((i (an-integer-between 1 j)))
           (require (= (+ (* i i) (* j j)) (* k k)))
           (list i j k))))))
(let ((a1 (amb-global-eval '(all-pythagorean-triples))))
  (let loop ()
    (print (next-val a1))
    (loop)))
