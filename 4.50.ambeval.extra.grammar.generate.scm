(mc-eval
 '(define (parse-word word-list)
    (list (car word-list)
          (random-element (cdr word-list))))) ;; Changed
