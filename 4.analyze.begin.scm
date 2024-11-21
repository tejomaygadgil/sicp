(define (install-begin-package)
  (include "4.3.metacircular.seq.scm")
  ;; Cons
  (define (make-begin seq) (cons 'begin seq))
  ;; Sel
  (define (begin-actions exp) (cdr exp))
  ;; Proc
  (define (analyze-sequence exps)
    (define (sequentially proc1 proc2)
      (lambda (env)
        (proc1 env)
        (proc2 env)))
    (define (loop first-proc rest-procs)
      (if (null? rest-procs)
          first-proc
          (loop (sequentially first-proc ; Beautiful
                              (car rest-procs))
                (cdr rest-procs))))
    (let ((procs (map analyze exps)))
      (if (null? procs)
          (error "Empty sequence -- ANALYZE-SEQUENCE")
          (loop (car procs) (cdr procs)))))
  (define (analyze-begin exp)
    (analyze-sequence (begin-actions exp)))
  ;; Install
  (put 'make 'begin make-begin)
  (put 'eval 'analyze-sequence analyze-sequence)
  (put 'eval 'begin analyze-begin)
  'ok)
;; Interface
(define (make-begin seq)
  ((get 'make 'begin) seq))
(define (analyze-sequence exp)
  ((get 'eval 'analyze-sequence) exp))
