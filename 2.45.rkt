;;;; 2.45
;; `Right-split` and `up-split` can be expressed as instances of a general splitting operation. Define a procedure `split` with the property that evaluating

(define right-split (split beside below))
(define up-split (split below beside))

;; produces procedures `right-split` and `up-split` with the same behaviors as the ones already defined.

;;; Answer
(load "2.painter.rkt")
(define (split proc1 proc2)
  ((rec painter n)
    (if (= n 0)
        painter
        (let ((smaller (rec painter (- n 1))))
          (proc1 painter (proc2 smaller smaller)))))
  rec)

;; Test
(paint-to-png (up-split einstein 1) "2.45.a.png" 1024 1024)
(paint-to-png (right-split einstein 1) "2.45.b.png" 1024 1024)
