(load "0.util.scm")
(define (global-eval exp)
  (if (eq? exp 'try-again)
    (try-again)
    (ambeval exp ; Changed
             the-global-environment
             (lambda (val next-alternative)  val)
             (lambda () '()))))
(define (print-global-eval exp)
  (print (global-eval exp)))
(define (test-global-eval exp val)
  (test (global-eval exp) val))
(define (amb-global-eval exp)
  (let ((res (cons false '()))
        (val (lambda (res) (car res)))
        (next (lambda (res) (cdr res))))
    (define (dispatch m)
      (cond ((eq? m 'next)
             (if (eq? (next res) 'done) 'done
               (begin
                 (set! res
                   (if (null? (next res))
                     (ambeval exp
                              the-global-environment
                              (lambda (val next-alternative)
                                (cons val next-alternative))
                              (lambda () (cons '() 'done)))
                     ((next res))))
                 (val res))))))
    dispatch))
(define (next-val amb)
  (amb 'next))
(define (print-amb exp)
  (let ((a1 (amb-global-eval exp)))
    (let loop ()
      (let ((val (next-val a1)))
        (if (not (null? val))
          (begin (print val)
                 (loop)))))))
