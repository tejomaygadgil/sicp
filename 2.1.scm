;;;; 2.1
;; Define a better version of `make-rat` that handles both positive and negative arguments. `Make-rat` should normalize the sign so that if the rational number is positive, both the numerator and denominator are positive, and if the rational number is negative, only the numerator is negative.

;;; Answer
(define (make-rat n d)
  (let ((g (gcd n d)))
    (if (> d 0)
      (cons (/ n g) (/ d g))
      (cons (/ (* -1 n) g) (/ (* -1 d) g)))))

;; Test
(map
  (lambda (x)
    (display x)
    (newline))
  (list (make-rat 5 6)
        (make-rat 10 12)
        (make-rat -5 6)
        (make-rat 5 -6)
        (make-rat -5 -6)))
