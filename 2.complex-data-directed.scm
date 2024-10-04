;; Abstract interface       (add-complex, sub-complex, mul-complex, div-complex)
;; Data abstraction         (real-part, imag-part, magnitude, angle)
;; Abstract procedure       (apply-generic)
;; Tagged data              (type-tag, contents, attach-tag)
;; Multiple representation  (...)

(load "2.data-directed.scm")
(load "2.complex-interface.scm")
(load "2.complex-abstraction.scm")
(load "2.complex-polar.scm")
(load "2.complex-rectangular.scm")

(define *op-table* (make-hash-table))

;; Install representations
(install-complex-polar-package)
(install-complex-rectangular-package)
