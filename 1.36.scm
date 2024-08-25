;;;; 1.36
;; Modify `fixed-point` so that it prints the sequence of approximations it generates, using the `newline` and `display` primitives shown in exercise 1.22. Then find a solution to $x^x = 1000$ by finding a fixed point of $x \rightarrow \log(1000)/log(x)$. (Use Scheme's primitive `log` procedure, which computes natural logarithms.) Compare the number of steps this takes with and without average damping. (Note that you cannot start `fixed-point` with a guess of 1, as this would cause division by $`log(1) = 0$.)

;;; Answer
(define (fixed-point f initial-guess)
  (define tolerance 0.00001)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess i)
    (let ((next-guess (f guess)))
      (display i)
      (display ": ")
      (display next-guess)
      (newline)
      (if (close-enough? guess next-guess)
        next-guess
        (try next-guess (+ i 1)))))
  (try initial-guess 1))

;; Test
(display "No damping")
(newline)
(define x-raised-to-x
  (fixed-point (lambda (x) (/ (log 1000) (log x)))
               2.))

(display "With damping")
(newline)
(define x-raised-to-x-damped
  (fixed-point (lambda (x) (/ (+ (/ (log 1000) (log x)) x) 2))
               2.))

;; Damping is 3x faster:
;; No damping
;; 1: 9.965784284662087
;; 2: 3.004472209841214
;; 3: 6.279195757507157
;; 4: 3.759850702401539
;; 5: 5.215843784925895
;; 6: 4.182207192401397
;; 7: 4.8277650983445906
;; 8: 4.387593384662677
;; 9: 4.671250085763899
;; 10: 4.481403616895052
;; 11: 4.6053657460929
;; 12: 4.5230849678718865
;; 13: 4.577114682047341
;; 14: 4.541382480151454
;; 15: 4.564903245230833
;; 16: 4.549372679303342
;; 17: 4.559606491913287
;; 18: 4.552853875788271
;; 19: 4.557305529748263
;; 20: 4.554369064436181
;; 21: 4.556305311532999
;; 22: 4.555028263573554
;; 23: 4.555870396702851
;; 24: 4.555315001192079
;; 25: 4.5556812635433275
;; 26: 4.555439715736846
;; 27: 4.555599009998291
;; 28: 4.555493957531389
;; 29: 4.555563237292884
;; 30: 4.555517548417651
;; 31: 4.555547679306398
;; 32: 4.555527808516254
;; 33: 4.555540912917957
;; 34: 4.555532270803653
;; With damping
;; 1: 5.9828921423310435
;; 2: 4.922168721308343
;; 3: 4.628224318195455
;; 4: 4.568346513136242
;; 5: 4.5577305909237005
;; 6: 4.555909809045131
;; 7: 4.555599411610624
;; 8: 4.5555465521473675
;; 9: 4.555537551999825
