(define (apply-generic op . args)
  (define (no-drop? op) (get 'no-drop op))
  (define (raise-to source target)
    (let ((target-type (type-tag target)))
      (let iter ((source source))
        (let ((raised (raise source)))
          (if (or (not-found? target-type)
                  (not-found? raised)) false ; Fail case
            (let ((raised-type (type-tag raised)))
              (cond ((equal? raised-type target-type) raised) ; Base case
                    (raised (iter raised))))))))) ; Reduction step
  (define (drop arg)
    (let ((projected (project arg)))
      (if (and (not (not-found? projected)) ; Short-circuit to base case
               (equ? arg (raise projected)))
        (drop projected) ; Reduction step (keep projecting)
        arg))) ; Base case (identify function if no projection exists, or arg is not typed (*))
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
        (let ((result (apply proc (map contents args))))
          (if (no-drop? op) result ; Prevent infinite recursion (*)
            (drop result))) ; Base case (modified from 2.84)
        (if (= (length args) 2)
          (let ((arg1 (car args))
                (arg2 (cadr args)))
            (if (equal? (type-tag arg1)
                        (type-tag arg2))
              (error "Missing same-type op -- APPLY-GENERIC" op args)
              (let ((raise1 (raise-to arg1 arg2)))
                (if raise1 (apply-generic op raise1 arg2) ; Reduce left
                  (let ((raise2 (raise-to arg2 arg1)))
                    (if raise2 (apply-generic op arg1 raise2) ; Reduce right
                      'not-found)))))) ; Fail case
          'not-found))))) ; Fail case
