;;;; 4.38.
;; Modify the multiple-dwelling procedure to omit the requirement that Smith and Fletcher do not live on adjacent floors. How many solutions are there to this modified puzzle?

;;; Answer
(define dwellings
    '(let ((baker (amb 1 2 3 4 5))
        (cooper (amb 1 2 3 4 5))
        (fletcher (amb 1 2 3 4 5))
        (miller (amb 1 2 3 4 5))
        (smith (amb 1 2 3 4 5)))
    (require
     (distinct? (list baker cooper fletcher miller smith)))
    (require (not (= baker 5)))
    (require (not (= cooper 1)))
    (require (not (= fletcher 5)))
    (require (not (= fletcher 1)))
    (require (> miller cooper))
    ; (require (not (= (abs (- smith fletcher)) 1))) ; Changed
    (require (not (= (abs (- fletcher cooper)) 1)))
    (list (list 'baker baker)
          (list 'cooper cooper)
          (list 'fletcher fletcher)
          (list 'miller miller)
          (list 'smith smith))))

;; Test
(load "4.amb.scm")
(let ((a1 (amb-global-eval dwellings)))
  (let ((res
          (let collect ()
            (let ((val (next-val a1)))
              (if (null? val) '()
                (append (list val)
                        (collect)))))))
    (display (length res))
    (display " solutions:")
    (newline)
    (map print res)))
