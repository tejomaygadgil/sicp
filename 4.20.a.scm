;;; Answer
(define (install-letrec)
  ;; Proc
  (define (letrec->let exp)
    (make-let (map (lambda (x) (list x '*unassigned*))
                   (let-args exp))
              (make-begin (append (map make-assignment
                                       (let-defs exp))
                                  (let-body exp)))))
  (define (eval-letrec exp env)
    (eval (letrec->let exp) env))
  (put 'eval 'letrec eval-letrec)
  'ok)
