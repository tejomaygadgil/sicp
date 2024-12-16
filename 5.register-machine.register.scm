;; Cons
(define (make-register name)
  (let ((contents '*unassigned*))
    (define (dispatch m)
      (cond ((eq? m 'get) contents)
            ((eq? m 'set)
             (lambda (value) (set! contents value)))
            (else
              (error "Unknown request -- REGISTER" m))))
    dispatch))
;; Interface
(define (get-contents register)
  (register 'get))
(define (set-contents! register value)
  ((register 'set) value))
;; Proc
(define (advance-pc pc)
  (set-contents! pc (cdr (get-contents pc))))
