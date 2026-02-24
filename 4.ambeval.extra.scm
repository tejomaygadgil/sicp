(define mc-mess-amb-skip '(self-evaluating variable quote define lambda))

(define (mc-mess-amb type exp)
  (if (and mc-mess
           (not (memq type mc-mess-amb-skip)))
      (begin (display "Evaluating ")
             (print type)
             (pp exp)
             (newline))))

(define mc-eval-depth 5)

(define (mc-eval exp)
  (catch
    (lambda ()
      (let* ((amb (ambeval exp
                           the-global-environment
                           (lambda (val next-alternative)
                             (cons val next-alternative))
                           (lambda () '())))
             (val (car amb))
             (rest (let loop ((amb ((cdr amb)))
                              (depth 2))
                     (cond ((null? amb) '())
                           ((< mc-eval-depth depth) '(...))
                           (else (cons (car amb)
                                       (loop ((cdr amb))
                                             (1+ depth))))))))
        (if (null? rest) val
            (cons val rest))))))

(define (install-amb-extras)
  (map mc-eval
       '((define (require p)
           (if (not p) (amb)))
         (define (an-element-of items)
           (require (not (null? items)))
           (amb (car items) (an-element-of (cdr items))))
         (define (an-integer-starting-from n)
           (amb n (an-integer-starting-from (+ n 1))))
         (define (an-integer-between a b)
           (require (not (< b a)))
           (amb a (an-integer-between (+ a 1) b)))
         (define (distinct? items)
           (cond ((null? items) true)
                 ((null? (cdr items)) true)
                 ((member (car items) (cdr items)) false)
                 (else (distinct? (cdr items)))))))
  'ok)
