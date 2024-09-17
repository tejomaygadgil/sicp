;;;; 2.51
;; Make changes to the square limit of `wave` shown in figure 2.9 by working at each of the levels described above. In particular:
;;
;; a.  Add some segments to the primitive `wave` painter of exercise 2.49 (to add a smile, for example).
;;
;; b.  Change the pattern constructed by `corner-split` (for example, by using only one copy of the `up-split` and `right-split` images instead of two).
;;
;; c.  Modify the version of `square-limit` that uses `square-of-four` so as to assemble the corners in a different pattern. (For example, you might make the big Mr. Rogers look outward from each corner of the square.)

;;; Answer
(load "2.painter.rkt")
;; a. Painter
(define draw_wave
   (list
    (segment (vect 0.20 0.00) (vect 0.35 0.50))
    (segment (vect 0.35 0.50) (vect 0.30 0.60))
    (segment (vect 0.30 0.60) (vect 0.15 0.45))
    (segment (vect 0.15 0.45) (vect 0.00 0.60))
    (segment (vect 0.00 0.80) (vect 0.15 0.65))
    (segment (vect 0.15 0.65) (vect 0.30 0.70))
    (segment (vect 0.30 0.70) (vect 0.40 0.70))
    (segment (vect 0.40 0.70) (vect 0.35 0.85))
    (segment (vect 0.35 0.85) (vect 0.40 1.00))
    (segment (vect 0.60 1.00) (vect 0.65 0.85))
    (segment (vect 0.65 0.85) (vect 0.60 0.70))
    (segment (vect 0.60 0.70) (vect 0.75 0.70))
    (segment (vect 0.75 0.70) (vect 1.00 0.40))
    (segment (vect 1.00 0.20) (vect 0.60 0.48))
    (segment (vect 0.60 0.48) (vect 0.80 0.00))
    (segment (vect 0.40 0.00) (vect 0.50 0.30))
    (segment (vect 0.50 0.30) (vect 0.60 0.00))
    (segment (vect 0.44 0.70) (vect 0.51 0.70))
    (segment (vect 0.44 0.70) (vect 0.44 0.71))
    (segment (vect 0.51 0.70) (vect 0.51 0.71))))

;; b. f(Combiners)
(define (split proc1 proc2)
  ((rec painter n)
    (if (= n 0)
        painter
        (let ((smaller (rec painter (- n 1))))
          (proc1 painter (proc2 smaller smaller)))))
  rec)
(define right-split (split beside below))
(define up-split (split below beside))

;; c. f(f(combiners)
(define (square-of-four tl tr bl br)
  (lambda (painter)
    (let ((top (beside (tl painter) (tr painter)))
          (bottom (beside (bl painter) (br painter))))
      (below bottom top))))
(define (square-limit painter n)
  (let ((combine4 (square-of-four identity flip-horiz
                                  flip-vert rotate180)))
    (combine4 (corner-split painter n))))

;; Test
(paint-to-png (segments->painter draw_wave) "2.52.a.png" 1024 1024)
(paint-to-png (corner-split (segments->painter draw_wave) 3) "2.52.b.png" 1024 1024)
(paint-to-png (square-limit (segments->painter draw_wave) 3) "2.52.c.png" 1024 1024)
