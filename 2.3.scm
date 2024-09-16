;;;; 2.3
;; Implement a representation for rectangles in a plane. (Hint: You may want to make use of exercise 2.2.) In terms of your constructors and selectors, create procedures that compute the perimeter and the area of a given rectangle. Now implement a different representation for rectangles. Can you design your system with suitable abstraction barriers, so that the same perimeter and area procedures will work using either representation?

;;; Answer
(load "2.2.scm")
;; Abstract methods
(define (perimeter rectangle)
  (* 2 (+ (width rectangle) (height rectangle))))
(define (area rectangle)
  (* (width rectangle) (height rectangle)))

;; Representation 1
(define (rectangle center-point width height)
  (cons center-point (cons width height)))
(define (width rectangle)
     (car (cdr rectangle)))
(define (height rectangle)
     (cdr (cdr rectangle)))

;; Test
(define rect1 (rectangle (make-point 5 5) 10 2))
(display rect1)
(newline)
(display (perimeter rect1))
(newline)
(display (area rect1))
(newline)

;; Representation 2
(define (rectangle bottom-left top-right)
  (cons bottom-left top-right))
(define (width rectangle)
  (- (x-point (cdr rectangle))
     (x-point (car rectangle))))
(define (height rectangle)
  (- (y-point (cdr rectangle))
     (y-point (car rectangle))))

;; Test
(define rect2 (rectangle (make-point 0 4) (make-point 10 6)))
(display rect2)
(newline)
(display (perimeter rect2))
(newline)
(display (area rect2))
(newline)
