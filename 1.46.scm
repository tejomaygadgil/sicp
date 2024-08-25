;;;; 1.46
;; Several of the numerical methods described in this chapter are instances of an extremely general computational strategy known as *iterative improvement*. Iterative improvement says that, to compute something, we start with an initial guess for the answer, test if the guess is good enough, and otherwise improve the guess and continue the process using the improved guess as the new guess. Write a procedure `iterative-improve` that takes two procedures as arguments: a method for telling whether a guess is good enough and a method for improving a guess. `Iterative-improve` should return as its value a procedure that takes a guess as argument and keeps improving the guess until it is good enough. Rewrite the `sqrt` procedure of section 1.1.7 and the `fixed-point` procedure of section 1.3.3 in terms of `iterative-improve`.

;;; Answer
(load "1.newtons-method.scm")
(define initial-guess 1.0)
(define (iterative-improve good-enough? improve)
  (define (iter guess)
    (let ((new-guess (improve guess)))
      (if (close-enough? guess new-guess)
          new-guess
          (iter new-guess))))
  (iter initial-guess))

(define (iterative-sqrt x)
  (define (improve x)
    (lambda (y) (/ (+ y (/ x y)) 2)))
  (iterative-improve close-enough? (improve x)))

;; Test
(display (iterative-sqrt 2))
(newline)
