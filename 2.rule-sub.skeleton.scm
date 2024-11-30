(define (skeleton-evaluation? skeleton)
  (if (pair? skeleton)
      (eq? (car skeleton) ':)
      false))

(define (evaluation-exp skeleton)
  (cadr skeleton))
