(define mc-mess false)

(define (mc-mess-eval exp)
  (if (and mc-mess
           (not (self-evaluating? exp))
           (not (variable? exp)))
      (begin (print "Evaluating")
             (pp exp)
             (newline))))

(define (mc-mess-apply procedure arguments)
  (if mc-mess
      (begin (print "Applying")
             (user-print procedure) (newline)
             (display "on ")
             (map (lambda (x) (user-print x) (display " ")) arguments)
             (newline) (newline))))

(define (mc-eval exp)
  (catch (lambda ()
           (eval exp the-global-environment))))

(define (mc-print exps)
  (for-each (lambda (x)
              (user-print x)
              (newline))
            (map mc-eval
                 exps))
  'ok)

(define (mc-test exp val)
  (test (mc-eval exp) val))

(define (install-extras)
  (for-each mc-eval
            '((define (enumerate-interval low high)
                (if (> low high) '()
                    (cons low (enumerate-interval (+ low 1) high))))
              (define (map proc seq)
                (if (null? seq)
                    '()
                    (cons (proc (car seq))
                          (map proc (cdr seq)))))
              (define (filter pred seq)
                (cond ((null? seq) '())
                      ((pred (car seq))
                       (cons (car seq)
                             (filter pred (cdr seq))))
                      (else (filter pred (cdr seq)))))
              (define (accumulate op initial sequence)
                (if (null? sequence) initial
                    (op (car sequence)
                        (accumulate op initial (cdr sequence)))))
              (define (list-ref items n)
                (if (= n 0)
                    (car items)
                    (list-ref (cdr items) (- n 1))))))
  'ok)
