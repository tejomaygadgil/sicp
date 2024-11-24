(newline)
(print "Testing lazy-stream evaluator")
(map global-eval
     '((define (integral integrand initial-value dt)
         (define int
           (cons initial-value
                 (add-lists (scale-list integrand dt)
                            int)))
         int)
       (define (solve f y0 dt)
         (define y (integral dy y0 dt))
         (define dy (map f y))
         y)))
(if (within-delta?
      (global-eval '(list-ref (solve (lambda (x) x) 1 0.001) 1000))
      2.71828183
      1e-2)
  (display 'pass))

