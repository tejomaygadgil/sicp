;;;; 4.8
;; "Named let" is a variant of `let` that has the form
;;
;; (let <var> <bindings> <body>)
;;
;; The `<bindings>` and ~<body>~ are just as in ordinary ~let~, except that `<var>` is bound within `<body>` to a procedure whose body is `<body>` and whose parameters are the variables in the `<bindings>`. Thus, one can repeatedly execute the `<body>` by invoking the procedure named `<var>`. For example, the iterative Fibonacci procedure (section 1.2.2) can be rewritten using named `let` as follows:
;;
;; (define (fib n)
;;   (let fib-iter ((a 1)
;;                  (b 0)
;;                  (count n))
;;     (if (= count 0)
;;         b
;;         (fib-iter (+ a b) a (- count 1)))))
;;
;; Modify `let->combination` of exercise 4.6 to also support named `let`.

;;; Answer
(define (install-let-package)
  ;; Cons
  (define (make-let defs body)
    (cons 'let (cons defs body)))
  ;; Sel
  (define (let-name exp)
    (if (symbol? (cadr exp))
        (cadr exp)
        false))
  (define (let-defs exp)
    (if (let-name exp)
        (caddr exp)
        (cadr exp)))
  (define (let-body exp)
    (if (let-name exp)
        (cdddr exp)
        (cddr exp)))
  (define (let-args exp)
    (map car (let-defs exp)))
  (define (let-vals exp)
    (map cadr (let-defs exp)))
  ;; Proc
  (define (let->combination exp)
    (if (let-name exp)
        (let ((name (let-name exp))
              (args (let-args exp))
              (vals (let-vals exp))
              (body (let-body exp)))
          (make-begin (list
                        (make-definition (cons name args)
                                         (make-begin body))
                        (cons name vals))))
        (cons (make-lambda (let-args exp)
                           (let-body exp))
              (let-vals exp))))
  ;; Install
  (put 'make 'let make-let)
  (put 'eval 'let (lambda (exp env) (eval (let->combination exp) env)))
  'ok)
;; Interface
(define (make-let defs body)
  ((get 'make 'let) defs body))
