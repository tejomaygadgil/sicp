;; Inherit
(load "4.ambeval.scm")
;; Expression types
(load "4.78.ambeval.eval.waive.scm")
;; Driver
(define primitive-procedures
  (append
   primitive-procedures
   (list (list 'get
               (lambda (op type)
                 (hash-table/get *query-table*
                                 (list op type)
                                 false)))
         (list 'put
               (lambda (op type proc)
                 (hash-table/put! *query-table*
                                  (list op type)
                                  proc)))
         (list 'apply apply-in-underlying-scheme)
         (list 'eval
               (lambda (x)
                 (eval-in-underlying-scheme x user-initial-environment)))
         (list 'symbol->string symbol->string)
         (list 'string->symbol string->symbol)
         (list 'string=? string=?)
         (list 'substring substring)
         (list 'string-append string-append)
         (list 'string-length string-length))))
;; Setup
(define *query-table* (make-hash-table)) ;; For embedded query language
(define the-global-environment (setup-environment))
(install-waive-package)
(install-amb-extras)
(install-extras)
