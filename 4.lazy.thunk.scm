;;; Delay
;; Cons
(define (delay-it exp env)
  (list 'thunk exp env))
;; Sel
(define (thunk-exp thunk)
  (cadr thunk))
(define (thunk-env thunk)
  (caddr thunk))
;; Pred
(define (thunk? obj)
  (tagged-list? obj 'thunk))
;; Proc
(define (actual-value exp env)
  (force-it (eval exp env)))

;;; Memo
;; Sel
(define (thunk-value evaluated-thunk)
  (cadr evaluated-thunk))
;; Pred
(define (evaluated-thunk? obj)
  (tagged-list? obj 'evaluated-thunk))
;; Mut
(define (convert-to-evaluated-thunk obj result)
  (set-car! obj 'evaluated-thunk)
  (set-car! (cdr obj) result)  ; replace exp with its value
  (set-cdr! (cdr obj) '())     ; forget unneeded env
  'ok)
;; Proc
(define (force-it obj)
  (cond ((thunk? obj)
         (let ((result (actual-value (thunk-exp obj)
                                     (thunk-env obj))))
           (convert-to-evaluated-thunk obj result)
           result))
        ((evaluated-thunk? obj)
         (thunk-value obj))
        (else obj)))
