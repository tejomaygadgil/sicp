;; Sel
(define (get-symbol parameter)
  (if (pair? parameter)
      (car parameter)
      parameter))
;; Pred
(define (applicative? parameter)
  (symbol? parameter))
(define (lazy? parameter)
  (and (pair? parameter)
       (eq? (cadr parameter) 'lazy)))
(define (lazy-memo? parameter)
  (and (pair? parameter)
       (eq? (cadr parameter) 'lazy-memo)))
