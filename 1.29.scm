;;;; 1.29
;; Simpson's Rule is a more accurate method of numerical integration than the method illustrated above. Using Simpson's Rule, the integral of a function f between a and b is approximated as
;;
;; h/3 [y_0 + 4y_1 + 2y_2 + 4y_3 + 2y_4 + ... + 2y_{n-2} + 4y_{n-1} y_n]
;;
;; where $h = (b - a)/n$, for some even integer $n$, and $y_k = f(a + kh)$. (Increasing $n$ increases the accuracy of the approximation.) Define a procedure that takes as arguments $f$, $a$, $b$, and $n$ and returns the value of the integral, computed using Simpson's Rule. Use your procedure to integrate `cube` between 0 and 1 (with n = 100 and n = 1000), and compare the results to those of the integral procedure shown above.

;;; Answer
(define (sum term a next b)
  (if (> a b)
    0
    (+ (term a)
       (sum term (next a) next b))))

(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b)
     dx))

(define (simpson f a b n)
  (define (1+ x) (+ 1 x))
  (define h (/ (- b a) n))
  (define (simp-func i)
    (define f-val (f (+ a (* i h))))
    (cond ((or (= i 0) (= i n)) f-val)
          ((= (remainder i 2) 0) (* 2 f-val))
          (else (* 4 f-val))))
  (* (/ h 3)
     (sum simp-func 0 1+ n)))

;; Test
(define (cube x) (expt x 3))
(map (lambda (x)
  (display "n ")
  (display x)
  (display "\t simpson ")
  (display (simpson cube 0 1 x))
  (display "\t integral ")
  (display (integral cube 0 1 (/ 1 x)))
  (newline))
     '(100 1000))

;; Simpson's Rule gives the precise value for the cube integral --
;; n 100    simpson 1/4     integral .24998750000000042
;; n 1000   simpson 1/4     integral .249999875000001
