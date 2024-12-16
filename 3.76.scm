;;;; 3.76
;;  Eva Lu Ator has a criticism of Louis's approach in exercise 3.75. The program he wrote is not modular, because it intermixes the operation of smoothing with the zero-crossing extraction. For example, the extractor should not have to be changed if Alyssa finds a better way to condition her input signal. Help Louis by writing a procedure `smooth `that takes a stream as input and produces a stream in which each element is the average of two successive input stream elements. Then use `smooth` as a component to implement the zero-crossing detector in a more modular style.

;;; Answer
(define (smooth stream)
  (let ((average (lambda (x y) (/ (+ x y) 2))))
    (stream-map average
                stream
                (cdr-stream stream))))
(define (make-zero-crossings input-stream)
  (let ((smoothed-stream (smooth input-stream)))
    (stream-map sign-change-detector
                smoothed-stream
                (stream-cdr smoothed-stream))))
