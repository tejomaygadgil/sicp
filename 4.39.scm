;;;; 4.39
;; Does the order of the restrictions in the multiple-dwelling procedure affect the answer? Does it affect the time to find an answer? If you think it matters, demonstrate a faster program obtained from the given one by reordering the restrictions. If you think it does not matter, argue your case.

;;; Answer
;; Multiple-dwelling problem is commutative, so the order
;; of the restrictions does not chenge the result. However,
;; computationally expensive predicates should come after
;; computationally inexpensive predicates to minimize the
;; number times they have to be called.
(define original-order
  '(let ((baker (amb 1 2 3 4 5))
         (cooper (amb 1 2 3 4 5))
         (fletcher (amb 1 2 3 4 5))
         (miller (amb 1 2 3 4 5))
         (smith (amb 1 2 3 4 5)))
     (require (distinct? (list baker cooper fletcher miller smith)))
     (require (not (= baker 5)))
     (require (not (= cooper 1)))
     (require (not (= fletcher 5)))
     (require (not (= fletcher 1)))
     (require (> miller cooper))
     (require (not (= (abs (- smith fletcher)) 1)))
     (require (not (= (abs (- fletcher cooper)) 1)))
     (list (list 'baker baker)
           (list 'cooper cooper)
           (list 'fletcher fletcher)
           (list 'miller miller)
           (list 'smith smith))))
(define efficient-order
  '(let ((baker (amb 1 2 3 4 5))
         (cooper (amb 1 2 3 4 5))
         (fletcher (amb 1 2 3 4 5))
         (miller (amb 1 2 3 4 5))
         (smith (amb 1 2 3 4 5)))
     (require (> miller cooper))
     (require (not (= fletcher 5)))
     (require (not (= fletcher 1)))
     (require (not (= baker 5)))
     (require (not (= cooper 1)))
     (require (not (= (abs (- smith fletcher)) 1)))
     (require (not (= (abs (- fletcher cooper)) 1)))
     (require (distinct? (list baker cooper fletcher miller smith)))
     (list (list 'baker baker)
           (list 'cooper cooper)
           (list 'fletcher fletcher)
           (list 'miller miller)
           (list 'smith smith))))

;; Test
(load "4.amb.scm")
(let ((a1 (amb-global-eval efficient-order))
      (a2 (amb-global-eval original-order))
      (time-amb (lambda (amb) (lambda ()
                               (let loop ()
                                 (let ((val (next-val amb)))
                                   (if (not (null? val))
                                     (begin (loop)))))))))
  (let ((a1-time (elapsed (time-amb a1)))
        (a2-time (elapsed (time-amb a2))))
    (display "Re-ordering the restrictions is ") ; ~15% improvement
    (display (/ (round (* (/ (- a2-time a1-time) a2-time) 1e4)) 1e2))
    (display "% faster")))
