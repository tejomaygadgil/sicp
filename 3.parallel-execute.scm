(define (kill-thread thread)
  (let ((event (lambda () (exit-current-thread 'RIP))))
    (without-interrupts
      (lambda ()
        (case (thread-execution-state thread)
          ((STOPPED) (restart-thread thread #t event))
          ((DEAD) unspecific)
          (else (signal-thread-event thread event)))))))

(define (parallel-execute . thunks)
  (let ((my-threads '()))
    (define (terminator)
      (without-interrupts
        (lambda ()
          (for-each kill-thread my-threads)
          (set! my-threads '())
          unspecific)))
    (without-interrupts
      (lambda ()
        (set!
          my-threads
          (map
            (lambda (thunk)
              (let ((thread (create-thread #f thunk)))
                (detach-thread thread)
                thread))
            thunks))
        unspecific))
    terminator))
