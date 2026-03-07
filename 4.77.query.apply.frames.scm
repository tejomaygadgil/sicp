(define the-empty-frame
  (cons (list) (list)))

(define (empty-frame? frame)
  (equal? frame the-empty-frame))

(define (cons-frame bindings promises)
  (cons bindings promises))

(define (bindings frame)
  (car frame))

(define (promises frame)
  (cdr frame))

(define (binding-in-frame variable frame)
  (assoc variable (car frame)))

(define (add-promise promise frame)
  (cons-frame (bindings frame)
              (cons promise (promises frame))))

(define (add-binding binding frame)
  (cons-frame (cons binding (bindings frame))
              (promises frame)))

(define (cons-promise miss-proc test-proc)
  (lambda (frame)
    (cond ((miss-proc frame) 'missing)
          ((test-proc frame) frame)
          (else 'failed))))

(define (extend variable value frame)
  (let* ((binding (make-binding variable value))
         (new-frame (add-binding binding frame)))
    (let loop ((binds (bindings new-frame))
               (proms (promises new-frame))
               (failed-proms '()))
      (if (null? proms) (cons-frame binds failed-proms)
          (let* ((first-prom (car proms))
                 (rest-proms (cdr proms))
                 (yield (first-prom (cons-frame binds '()))))
            (cond ((eq? yield 'missing)
                   (loop binds
                         rest-proms
                         (cons first-prom failed-proms)))
                  ((eq? yield 'failed) yield)
                  (else
                   (loop (bindings yield)
                         rest-proms
                         failed-proms))))))))

(define (missing-bindings? exp frame)
  (let loop ((exp exp))
    (if (null? exp) false
        (let ((first-exp (car exp)))
          (if (and (var? first-exp)
                   (not (binding-in-frame first-exp frame))) true
                   (loop (cdr exp)))))))
