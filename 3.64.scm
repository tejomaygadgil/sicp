;;;; 3.64
;; Write a procedure `stream-limit` that takes as arguments a stream and a number (the tolerance). It should examine the stream until it finds two successive elements that differ in absolute value by less than the tolerance, and return the second of the two elements. Using this, we could compute square roots up to a given tolerance by

(define (sqrt x tolerance)
  (stream-limit (sqrt-stream x) tolerance))

;;; Answer
(define (stream-limit stream tolerance)
  (let iter ((stream stream)
             (steps 0))
    (let ((prev-value (stream-car stream))
          (next-value (stream-car (stream-cdr stream)))
          (within-tolerance? (lambda (x y t)  (< (abs (- x y)) t))))
      (cond ((within-tolerance? prev-value
                                next-value
                                tolerance)
             (begin (display steps)
                    (display " steps to converge to ")
                    (display next-value)
                    (newline)
                    next-value))
            (else (iter (stream-cdr stream)
                        (1+ steps)))))))

;; ;; Test
;; (define (sqrt-stream x)
;;   (define (average x y) (/ (+ x y) 2))
;;   (define (sqrt-improve guess x)
;;     (average guess (/ x guess)))
;;   (define guesses
;;     (cons-stream 1.0
;;                  (stream-map (lambda (guess)
;;                                (sqrt-improve guess x))
;;                              guesses)))
;;   guesses)
;; (define tolerance 1e-10)
;; (sqrt 2 tolerance)
