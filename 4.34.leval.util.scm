(define (mc-print exps)
  (for-each (lambda (x)
              (user-print x the-empty-history) ;; Changed
              (newline))
            (map mc-eval
                 exps))
  'ok)
