;;;; 4.34
;; Modify the driver loop for the evaluator so that lazy pairs and lists will print in some reasonable way. (What are you going to do about infinite lists?) You may also need to modify the representation of lazy pairs so that the evaluator can identify them in order to print them.

(load "4.lazy.scm")
(load "4.33.lazy-stream.quotation.scm")
(load "4.lazy-stream.map-lists.scm")
(install-quotation-package)
(install-map-lists-package)

;;; Answer
;; Tagging all `cons`'s as a 'lazy-pair allows `cons` to be
;; represented as a pair in the underlying evaluator where
;; the `car` is the 'lazy-pair element, and the `cdr` is
;; the procedure. As `car` and `cdr` are the only means of
;; accessing the data in `cons` modifying them is sufficient.
(load "4.34.lazy-stream.history.scm")
(load "4.34.lazy-stream.lazy-pair.scm")
(load "4.34.lazy-stream.driver.scm")
(load "4.34.lazy-stream.util.scm")
(load "4.34.lazy-stream.cons.scm")
(install-cons-package)

;; Test
(map global-eval
     '((define ones (cons 1 ones))
       (define integers (cons 1 (add-lists ones integers)))
       (define fibs (cons 0 (cons 1 (add-lists (cdr fibs) fibs))))))
(map (lambda (x)
       (print x)
       (print-global-eval x)
       (global-eval (list 'car x))
       (print-global-eval x)
       (global-eval (list 'list-ref x 10))
       (print-global-eval x)
       (newline))
     '(ones integers fibs))
