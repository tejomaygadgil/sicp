(define (simple-query query-pattern frame)
  (amb (find-assertions query-pattern frame)
       (apply-rules query-pattern frame)))

(define (find-assertions pattern frame)
  (let ((result (pattern-match pattern
                               (fetch-assertions pattern frame)
                               frame)))
    (require (not (eq? result 'failed)))
    result))

(define (pattern-match pat dat frame)
  (cond ((eq? frame 'failed) 'failed)
        ((equal? pat dat) frame)
        ((var? pat) (extend-if-consistent pat dat frame))
        ((and (pair? pat) (pair? dat))
         (pattern-match (cdr pat)
                        (cdr dat)
                        (pattern-match (car pat)
                                       (car dat)
                                       frame)))
        (else 'failed)))

(define (extend-if-consistent var dat frame)
  (let ((binding (binding-in-frame var frame)))
    (if binding
        (pattern-match (binding-value binding) dat frame)
        (extend var dat frame))))
