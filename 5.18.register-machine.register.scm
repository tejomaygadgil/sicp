;; Cons
(define (make-register name)
  (let ((contents '*unassigned*)
        (trace-on false))
    (define (dispatch m)
      (cond ((eq? m 'get) contents)
            ((eq? m 'set)
             (lambda (value)
               (when trace-on
                 (print 'reg name contents 'to value))
               (set! contents value)))
            ((eq? m 'trace-on)
             (set! trace-on true))
            ((eq? m 'trace-off)
             (set! trace-on false))
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
