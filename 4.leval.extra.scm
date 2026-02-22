(define (mc-mess-delay exp)
  (if mc-mess
      (begin (print "Delaying ")
             (print exp)
             (newline))))

(define (mc-mess-thunk obj)
  (if mc-mess
      (begin
        (display "Thunk -- ")
        (cond ((thunk? obj)
               (print "yes")
               (print (thunk-exp obj)))
              ((evaluated-thunk? obj)
               (print "evaluated")
               (print (thunk-value obj)))
              (else
               (print "no")
               (user-print obj)
               (newline)))
        (newline))))

(define (mc-eval exp)
  (catch (lambda ()
           (actual-value exp the-global-environment))))
