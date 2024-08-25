;;;; 1.35
;; Show that the golden ratio $\phi$ (section 1.2.2) is a fixed point of the transformation $x \rightarrow 1 + 1/x$, and use this fact to compute  $\phi$ by means of the `fixed-point` procedure.

;;; Answer
(load "1.fixed-point.scm")
(define phi
  (fixed-point (lambda (x) (+ 1 (/ 1 x)))
               1.))

(display phi)
(newline)
