;;; Naive thunk
;; Cons
(define (delay-it-naive exp env)
  (list 'naive-thunk exp env))
;; Pred
(define (naive-thunk? obj)
  (tagged-list? obj 'naive-thunk))

;;; Memoized delay
;; Proc
(define (force-it obj)
  (cond ((naive-thunk? obj) ; Added
         (actual-value (thunk-exp obj) (thunk-env obj)))
        ((thunk? obj)
         (let ((result (actual-value (thunk-exp obj)
                                     (thunk-env obj))))
           (convert-to-evaluated-thunk obj result)
           result))
        ((evaluated-thunk? obj)
         (thunk-value obj))
        (else obj)))
