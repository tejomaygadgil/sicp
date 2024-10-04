;; Abstract interface       (add-complex, sub-complex, mul-complex, div-complex)
;; Data abstraction         (real-part, imag-part, magnitude, angle)
;; Tagged data              (type-tag, contents, attach-tag)
;; Multiple representation  (...)

;; Tagged data
(load "2.tagged-data.scm")
(load "2.complex-interface.scm")

;; Data abstraction
;; Pred
(define (rectangular? z)
  (eq? (type-tag z) 'rectangular)) ; Data abstraction (type-tag)
(define (polar? z)
  (eq? (type-tag z) 'polar)) ; Data abstraction (type-tag)
;; Sel
(define (real-part z)
  (cond ((rectangular? z)
         (real-part-rectangular (contents z))) ; Data abstraction (contents)
        ((polar? z)
         (real-part-polar (contents z))) ; Data abstraction (contents)
        (else (error "Unknown type -- REAL-PART" z))))
(define (imag-part z)
  (cond ((rectangular? z)
         (imag-part-rectangular (contents z))) ; Data abstraction (contents)
        ((polar? z)
         (imag-part-polar (contents z))) ; Data abstraction (contents)
        (else (error "Unknown type -- IMAG-PART" z))))
(define (magnitude z)
  (cond ((rectangular? z)
         (magnitude-rectangular (contents z))) ; Data abstraction (contents)
        ((polar? z)
         (magnitude-polar (contents z))) ; Data abstraction (contents)
        (else (error "Unknown type -- MAGNITUDE" z))))
(define (angle z)
  (cond ((rectangular? z)
         (angle-rectangular (contents z))) ; Data abstraction (contents)
        ((polar? z)
         (angle-polar (contents z)))
        (else (error "Unknown type -- ANGLE" z))))
;; Cons
(define (make-from-real-imag x y)
  (make-from-real-imag-rectangular x y))
(define (make-from-mag-ang r a)
  (make-from-mag-ang-polar r a))

;;; Multiple representation
;; Rectangular (Ben)
;; Sel
(define (real-part-rectangular z) (car z))
(define (imag-part-rectangular z) (cdr z))
(define (magnitude-rectangular z)
  (sqrt (+ (square (real-part-rectangular z))
           (square (imag-part-rectangular z)))))
(define (angle-rectangular z)
  (atan (imag-part-rectangular z)
        (real-part-rectangular z)))
;; Cons
(define (make-from-real-imag-rectangular x y)
  (attach-tag 'rectangular (cons x y)))
(define (make-from-mag-ang-rectangular r a)
  (attach-tag 'rectangular
              (cons (* r (cos a)) (* r (sin a)))))
;; Polar (Alyssa)
;; Sel
(define (real-part-polar z)
  (* (magnitude-polar z) (cos (angle-polar z))))
(define (imag-part-polar z)
  (* (magnitude-polar z) (sin (angle-polar z))))
(define (magnitude-polar z) (car z))
(define (angle-polar z) (cdr z))
;; Cons
(define (make-from-real-imag-polar x y)
  (attach-tag 'polar
               (cons (sqrt (+ (square x) (square y)))
                     (atan y x))))
(define (make-from-mag-ang-polar r a)
  (attach-tag 'polar (cons r a)))
