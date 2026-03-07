(define (install-my-meetings)
  (mc-eval '(assert!
             (rule (my-meetings ?person ?day-and-time)
                   (or (and (job ?person (?division . ?job))
                            (meeting ?division ?day-and-time))
                       (meeting whole-company ?day-and-time))))))
