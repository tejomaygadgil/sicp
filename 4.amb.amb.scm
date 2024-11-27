(define (install-amb-package)
  ;;; Sel
  (define (amb-choices exp) (cdr exp))
  ;; Proc
  (define (analyze-amb exp)
    (let ((cprocs (map analyze (amb-choices exp))))
      (lambda (env succeed fail)
        (define (try-next choices)
          (if (null? choices)
            (fail)
            ((car choices) env
                           succeed
                           (lambda ()
                             (try-next (cdr choices))))))
        (try-next cprocs))))
  ;; Install
  (put 'eval 'amb analyze-amb)
  'ok)
