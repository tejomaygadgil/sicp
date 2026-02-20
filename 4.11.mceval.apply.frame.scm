(define (make-frame variables values)
  (if (null? variables) (list (cons '() '())) ;; Dummy element
      (cons (make-binding (car variables) (car values))
            (make-frame (cdr variables) (cdr values)))))

(define (add-binding-to-frame! var val frame)
  (set-cdr! frame
            (cons (make-binding var val)
                  (cdr frame)))
  'ok)

(define (set-binding-to-frame! var val frame)
  (set-car! frame
            (make-binding var val))
  'ok)

(define (first-binding frame)
  (car frame))

(define (rest-bindings frame)
  (cdr frame))

(define (make-binding var val)
  (cons var val))

(define (var-binding binding)
  (car binding))

(define (val-binding binding)
  (cdr binding))
