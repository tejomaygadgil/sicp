(define (install-ramb-package)
  ;; Sel
  (define (amb-choices exp) (cdr exp))
  ;; Proc
  (define (shuffle list) ; https://en.wikipedia.org/wiki/Fisher–Yates_shuffle
    (define (iter shuffled original)
      (if (null? original) shuffled
        (let ((i (random (length original))))
          (iter (cons (list-ref original i) shuffled)
                (append (take original i)
                        (cdr (drop original i)))))))
    (iter '() list))
  (define (analyze-ramb exp)
    (let ((cprocs (map analyze (amb-choices exp))))
      (lambda (env succeed fail)
        (let try-next ((choices (shuffle cprocs))) ; Changed
          (if (null? choices)
            (fail)
            ((car choices) env
                           succeed
                           (lambda ()
                             (try-next (cdr choices)))))))))
  ;; Install
  (put 'eval 'ramb analyze-ramb)
  'ok)
(define (install-random-element)
  (global-eval
    '(define (random-element items)
       (require (not (null? items)))
       (ramb (car items) (random-element (cdr items)))))
  'ok)
