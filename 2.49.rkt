;;;; 2.49
;; Use `segments->painter` to define the following primitive painters:
;;
;; a.  The painter that draws the outline of the designated frame.
;;
;; b.  The painter that draws an "X" by connecting opposite corners of the frame.
;;
;; c.  The painter that draws a diamond shape by connecting the midpoints of the sides of the frame.
;;
;; d.  The `wave` painter.

(load "2.painter.scm")
(load "2.48.scm")

(define bl (vect 0 0))
(define br (vect 0 1))
(define tl (vect 1 0))
(define tr (vect 1 1))
(define ml (vect 0 0.5))
(define mr (vect 1 0.5))
(define mb (vect 0.5 0))
(define mt (vect 0.5 1))

;; a
(define draw_frame
  (list (segment bl tl)
        (segment tl tr)
        (segment tr br)
        (segment br bl)))
(paint-to-png (segments->painter draw_frame) "2.49.a.png" 1024 1024)

;; b
(define draw_X
  (list (segment tr bl)
        (segment tl br)))
(paint-to-png (segments->painter draw_X) "2.49.b.png" 1024 1024)

;; c
(define draw_diamond
  (list (segment ml mb)
        (segment mb mr)
        (segment mr mt)
        (segment mt ml)))
(paint-to-png (segments->painter draw_diamond) "2.49.c.png" 1024 1024)

;; d
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
    (segment (vect 0.50 0.30) (vect 0.60 0.00))))
(paint-to-png (segments->painter draw_wave) "2.49.d.png" 1024 1024)
