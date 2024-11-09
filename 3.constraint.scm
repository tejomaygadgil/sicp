(load "3.constraint.constraint.scm")
(load "3.constraint.connector.scm")

(define (make-constant c)
  (let ((conn (make-connector)))
    (constant c conn)
    conn))

(define x1 (make-connector))
(define x2 (make-connector))
(probe 'x1 x1)
(probe 'x2 x2)
