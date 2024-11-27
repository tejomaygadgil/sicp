(define (install-begin-package)
  (include "4.3.metacircular.seq.scm")
  ;; Cons
  (define (make-begin seq) (cons 'begin seq))
  ;; Sel
  (define (begin-actions exp) (cdr exp))
  ;; Proc
  (define (analyze-sequence exps) ; Changed
    (define (sequentially a b)
      (lambda (env succeed fail)
        (a env
           (lambda (a-value fail2)
             (b env succeed fail2))
           fail)))
    (define (loop first-proc rest-procs)
      (if (null? rest-procs)
        first-proc
        (loop (sequentially first-proc (car rest-procs))
              (cdr rest-procs))))
    (let ((procs (map analyze exps)))
      (if (null? procs)
        (error "Empty sequence -- ANALYZE"))
      (loop (car procs) (cdr procs))))
  (define (analyze-begin exp)
    (analyze-sequence (begin-actions exp)))
  ;; Install
  (put 'make 'begin make-begin)
  (put 'interface 'analyze-sequence analyze-sequence)
  (put 'eval 'begin analyze-begin)
  'ok)
;; Interface
(define (make-begin seq)
  ((get 'make 'begin) seq))
(define (analyze-sequence exp)
  ((get 'interface 'analyze-sequence) exp))
