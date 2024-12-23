(load "3.serializer-mutex.scm")
(define (make-semaphore n)
  (let ((mutex (make-mutex))
        (n-procs 0))
    (define (acquire)
      (mutex 'acquire)
      (if (= n-procs n)
        (begin
          (mutex 'release)
          (acquire))
        (begin
          (set! n-procs (+ n-procs 1))
          (mutex 'release))))
    (define (release)
      (mutex 'acquire)
      (set! n-procs (- n-procs 1))
      (mutex 'release))
    (lambda (m)
      (cond ((eq? m 'acquire) (acquire))
            ((eq? m 'release) (release))
            (else (error "Unknown operation -- SEMAPHORE" m))))))
