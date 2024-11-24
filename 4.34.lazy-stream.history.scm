;; Obj
(define the-empty-history '())
;; Pred
(define (in-history? element history)
  (if (null? history) false
    (if (equal? element (car history)) true
      (in-history? element (cdr history)))))
