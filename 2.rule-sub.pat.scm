(define (arbitrary-constant? pat)
  (if (pair? pat)
      (eq? (car pat) '?c)
      false))

(define (arbitrary-expression? pat)
  (if (pair? pat)
      (eq? (car pat) '?)
      false))

(define (arbitrary-variable? pat)
  (if (pair? pat)
      (eq? (car pat) '?v)
      false))

(define (variable-name pat)
  (cadr pat))
