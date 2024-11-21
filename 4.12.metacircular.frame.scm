;; Cons
(define (make-frame variables values)
  (cons variables values))
;; Sel
(define (frame-variables frame) (car frame))
(define (frame-values frame) (cdr frame))
;; Mut
(define (add-binding-to-frame! var val frame)
  (set-car! frame (cons var (frame-variables frame)))
  (set-cdr! frame (cons val (frame-values frame))))
;; Proc
(define (scan-frame var frame)
  (let iter ((variables (frame-variables frame))
             (values (frame-values frame)))
    (cond ((null? variables) false)
          ((eq? var (car variables)) (cons variables values))
          (else (iter (cdr variables)
                      (cdr values))))))
