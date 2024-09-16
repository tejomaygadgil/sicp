;;;; 2.2
;; Consider the problem of representing line segments in a plane. Each segment is represented as a pair of points: a starting point and an ending point. Define a constructor `make-segment` and selectors `start-segment` and `end-segment` that define the representation of segments in terms of points. Furthermore, a point can be represented as a pair of numbers: the $x$ coordinate and the $y$ coordinate. Accordingly, specify a constructor `make-point` and selectors `x-point` and `y-point` that define this representation. Finally, using your selectors and constructors, define a procedure `midpoint-segment` that takes a line segment as argument and returns its midpoint (the point whose coordinates are the average of the coordinates of the endpoints). To try your procedures, you'll need a way to print points:

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

;;; Answer
;;; Point
;; Cons
(define (make-point x y) (cons x y))
;; Sel
(define (x-point point) (car point))
(define (y-point point) (cdr point))

;;; Segment
;; Cons
(define (make-segment start-point end-point) (cons start-point end-point))
;; Sel
(define (start-segment segment) (car segment))
(define (end-segment segment) (cdr segment))
;; Proc
(define (midpoint-segment segment)
  (let ((average (lambda (x y) (/ (+ x y) 2))))
    (make-segment (average (x-point (start-segment segment))
                           (x-point (end-segment segment)))
                  (average (y-point (start-segment segment))
                           (y-point (end-segment segment))))))

;; ;; Test
;; (define s (make-segment (make-point 3 5)
;;                         (make-point 7 6)))
;; (print-point (midpoint-segment s))
