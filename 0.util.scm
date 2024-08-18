(define (print . vals)
  (newline)
  (for-each (lambda (x) (display x)
                        (display " "))
            vals))

(define (global-eval exp)
  (eval exp user-initial-environment))

(define (eval-and-print exps)
  (for-each print
            (map global-eval
                 exps)))

(define (test x y)
  (if (equal? x y)
      (print 'pass)
      (error 'ne: x y)))

(define (elapsed func)
  (let ((current-time (runtime)))
    (func)
    (/ (round (* (- (runtime) current-time) 100)) 100)))

(define (repeat func n)
  (if (> n 0)
    (begin
      (print (func))
      (newline)
      (repeat func (- n 1)))))

(define (wait t)
  (define (get-current-time)
    (internal-time/ticks->seconds (real-time-clock)))
  (let ((start-time (get-current-time)))
    (define (loop)
      (if (> t (* (- (get-current-time) start-time)))
        (loop)))
    (loop)))
