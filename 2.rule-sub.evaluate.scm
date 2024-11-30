(define (evaluate form dict)
  (if (atom? form)
      (lookup form dict)
      (apply
        (eval (lookup (car form) dict)
              user-initial-environment)
        (map (lambda (v)
                (lookup v dict))
              (cdr form)))))
