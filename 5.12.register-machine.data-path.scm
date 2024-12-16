(define (data-path-parse flist alist text)
  (let ((op-parse
         (lambda (text)
           (let ((op (car text))
                 (args (cdr text)))
             ((flist 'put) op)
             (map (lambda (arg)
                    ((flist 'put) arg)
                    ((alist 'put) op arg))
                  args)))))
    (when (not (symbol? text)) ; ignore labels
      (let ((inst (car text))
            (rest (cdr text)))
        (cond ((eq? inst 'branch) 'skip) ; branch: [label]
              ((eq? inst 'goto) 'skip) ; goto: [label, reg]
              ((eq? inst 'save) ; save: [stack <- reg]
               (let ((head (list 'stack 'stack))
                     (tail (cons 'reg rest)))
                 ((flist 'put) head)
                 ((flist 'put) tail)
                 ((alist 'put) head tail)))
              ((eq? inst 'restore) ; restore: [reg <- stack]
               (let ((head (cons 'reg rest))
                     (tail (list 'stack 'stack)))
                 ((flist 'put) head)
                 ((flist 'put) tail)
                 ((alist 'put) head tail)))
              ((eq? inst 'perform) ; perform: [op <- args]
               (op-parse rest))
              ((eq? inst 'test) ; test: [op <- args]
               (op-parse (cons (list 'testop (cadar rest)) ; rename to 'testop
                               (cdr rest))))
              ((eq? inst 'assign) ; assign: [reg <- src]
               (let ((head (list 'reg (car rest)))
                     (tail (cdr rest)))
                 ((flist 'put) head)
                 (if (= (length tail) 1) ; reg, const, label
                     (let ((tail (car tail)))
                       ((flist 'put) tail)
                       ((alist 'put) head tail))
                     (op-parse tail))))
              (else
               (error "Unknown inst -- DATA PATH" inst)))))))
(define (data-path-dot flist alist opts)
  (let* ((dot-opts (apply string-append
                          (map (lambda (opt) (format false "~a; " opt))
                               opts)))
         (node-shapes '((reg box)
                        (stack box)
                        (const triangle)
                        (op trapezium)
                        (testop circle)
                        (label triangle)))
         (nodes (flatmap (lambda (x)
                           (let* ((type (car x))
                                  (shape (cadr (assoc type node-shapes))))
                             (map (lambda (name)
                                    (format false
                                            "\"~a_~a\"[label=\"~a\" shape=~a]; "
                                            type name name shape))
                                  (cdr x))))
                         (flist 'get)))
         (edges (flatmap (lambda (x)
                           (let ((head (car x)))
                             (map (lambda (tail)
                                    (format false
                                            "\"~a_~a\" -> \"~a_~a\"; "
                                            (car tail) (cadr tail)
                                            (car head) (cadr head)))
                                  (cadr x))))
                         (alist 'get))))
    (apply string-append
           (reduce-left append '()
                        (list (list "digraph { " dot-opts)
                              nodes edges
                              (list " }"))))))
