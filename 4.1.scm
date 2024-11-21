;;;; 4.1
;; Notice that we cannot tell whether the metacircular evaluator evaluates operands from left to right or from right to left. Its evaluation order is inherited from the underlying Lisp: If the arguments to `cons` in list-of-values are evaluated from left to right, then `list-of-values` will evaluate operands from left to right; and if the arguments to `cons` are evaluated from right to left, then `list-of-values` will evaluate operands from right to left.
;; Write a version of `list-of-values` that evaluates operands from left to right regardless of the order of evaluation in the underlying Lisp. Also write a version of `list-of-values` that evaluates operands from right to left.

;;; Answer
;; We control the order of evaluation by recursively nesting
;; operands within procedures using `let`. This works because
;; procedure arguments are always evaluted before the body.
(define (list-of-values exps env) ; Left-to-right
  (if (no-operand? exps)
      '()
      (let ((left (eval (first-operand exps) env)))
        (cons left
              (list-of-values (rest-operands exps) env)))))

;; Test
(define (eval exp env) (display exp) (display " ") exp)
(define (first-operand exps) (car exps))
(define (rest-operands exps) (cdr exps))
(define no-operand? null?)
(define exps (list 1 2 3 4))
(list-of-values exps 'env) ; 1 2 3 4
(newline)

(define (list-of-values exps env) ; Right-to-left
  (if (no-operand? exps)
      '()
      (let ((right (list-of-values (rest-operands exps) env)))
        (cons (eval (first-operand exps) env)
              right))))

;; Test
(list-of-values exps 'env) ; 4 3 2 1
