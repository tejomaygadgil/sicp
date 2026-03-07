(define (install-weekly-meetings)
  (for-each mc-eval
            (list '(assert! (meeting accounting (Monday 9am)))
                  '(assert! (meeting administration (Monday 10am)))
                  '(assert! (meeting computer (Wednesday 3pm)))
                  '(assert! (meeting administration (Friday 1pm)))
                  '(assert! (meeting whole-company (Wednesday 4pm))))))
