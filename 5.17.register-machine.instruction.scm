;; Cons
(define (make-instruction text)
  (list (list false text)
        '()))
;; Sel
(define (instruction-text inst)
  (cadar inst))
(define (instruction-label inst)
  (caar inst))
(define (instruction-text-type inst-text)
  (car inst-text))
(define (instruction-execution-proc inst)
  (cdr inst))
;; Mut
(define (set-instruction-execution-proc! inst proc)
  (set-cdr! inst proc))
(define (set-instruction-label! inst label)
  (when (not (instruction-label inst))
    (set-car! (car inst) label)))
