;;;; 2.44
;; Define the procedure `up-split` used by `corner-split`. It is similar to `right-split`, except that it switches the roles of `below` and `beside`.

;;; Answer
(load "2.painter.rkt")
(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split painter (- n 1))))
        (below painter (beside smaller smaller)))))

;; Test
(paint-to-png (up-split einstein 6) "2.44.png" 1024 1024)
