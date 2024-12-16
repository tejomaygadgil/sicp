;; Cons
(define (make-label-entry label-name insts)
  (cons label-name insts))
;; Proc
(define (lookup-label labels label-name)
  (let ((val (assoc label-name labels)))
    (if val (cdr val)
        (error "Undefined label -- ASSEMBLE" label-name))))
