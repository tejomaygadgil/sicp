;; Sel
(define (x-coord mag ang)
  (mul mag (cos ang)))
(define (y-coord mag ang)
  (mul mag (sin ang)))
(define (euclidean-distance x y)
  (sqrt (add (square x) (square y))))
(define (angle-from-coords x y)
  (atan y x))
