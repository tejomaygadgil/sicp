(define (install-last-pair)
  (for-each mc-eval
            (list '(assert! (rule (last-pair (?x) (?x)))) ;; Base case
                  '(assert! (rule (last-pair (?u . ?v) (?x))
                                  (last-pair ?v (?x))))))) ;; Recursive step
