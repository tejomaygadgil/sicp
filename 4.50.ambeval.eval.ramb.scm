(define (install-ramb-package)
  (put 'eval 'ramb
       (lambda (exp)
         (let ((cprocs (map analyze (amb-choices exp))))
           (lambda (env succeed fail)
             (let try-next ((choices (shuffle cprocs))) ;; Changed
               (if (null? choices)
                   (fail)
                   ((car choices) env
                    succeed
                    (lambda ()
                      (try-next (cdr choices))))))))))
  'ok)

(define (install-ramb-extras)
  (mc-eval
   '(define (random-element items)
      (require (not (null? items)))
      (ramb (car items)
            (random-element (cdr items)))))
  'ok)
