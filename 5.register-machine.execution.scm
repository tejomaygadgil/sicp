(define (make-execution-procedure inst-text labels machine
                                  pc flag stack ops)
  (let ((make (get 'exec (instruction-text-type inst-text))))
    (if make
        (make inst-text labels machine
              pc flag stack ops)
        (error "Unknown instruction type -- ASSEMBLE"
                inst-text))))
