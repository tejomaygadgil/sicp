;; Cons
(define (make-instruction text)
  (cons text '()))
;; Sel
(define (instruction-text inst)
  (car inst))
(define (instruction-text-type inst-text)
  (car inst-text))
(define (instruction-execution-proc inst)
  (cdr inst))
;; Mut
(define (set-instruction-execution-proc! inst proc)
  (set-cdr! inst proc))
