;;;; 2.50
;; Define the transformation `flip-horiz`, which flips painters horizontally, and transformations that rotate painters counterclockwise by 180 degrees and 270 degrees.

;;; Answer
(load "2.painter.rkt")
(define (flip-horiz painter)
  (transform-painter painter (vect 1 0)
                             (vect 0 0)
                             (vect 1 1)))
(define (180cc painter)
  (transform-painter painter (vect 1 1)
                             (vect 0 1)
                             (vect 1 0)))
(define (270cc painter)
  (transform-painter painter (vect 1 0)
                             (vect 1 1)
                             (vect 0 0)))

;; Test
(paint-to-png (flip-horiz einstein) "2.50.a.png" 1024 1024)
(paint-to-png (180cc einstein) "2.50.b.png" 1024 1024)
(paint-to-png (270cc einstein) "2.50.c.png" 1024 1024)
