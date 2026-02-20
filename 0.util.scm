(load-option 'format)

(define nil '())

(define (print . vals)
  (for-each (lambda (x) (display (format false "~a " x)))
            vals)
  (newline)
  'ok)

(define (catch proc)
    (guard (c (else (condition/report-string c)))
    (proc)))

(define (test x y)
  (if (equal? x y) 'ok
      (error 'ne: x y)))

(define (within-delta? actual guess delta)
  (< (abs (- guess actual))
     delta))

(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))

(define (elapsed func)
  (let ((current-time (runtime)))
    (func)
    (/ (round (* (- (runtime) current-time) 100)) 100)))

(define (repeat func trials)
  (if (> trials 0)
    (let ((return-value (func)))
      (print return-value)
      (repeat func (- trials 1)))))

(define (wait t)
  (define (get-current-time)
    (internal-time/ticks->seconds (real-time-clock)))
  (let ((start-time (get-current-time)))
    (define (loop)
      (if (> t (* (- (get-current-time) start-time)))
        (loop)))
    (loop)))

(define (until stream condition then-what timeout)
  (let loop ((stream stream)
             (time-left timeout))
    (if (zero? time-left) 'timeout
    (let ((result (stream-car stream)))
      (if (or (null? stream)
              (condition result)) (then-what stream)
        (loop (stream-cdr stream)
              (- time-left 1)))))))
