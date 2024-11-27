
;; Use the `amb` evaluator to solve the following puzzle
;;
;; Mary Ann Moore's father has a yacht and so has each of his four friends: Colonel Downing, Mr. Hall, Sir Barnacle Hood, and Dr. Parker. Each of the five also has one daughter and each has named his yacht after a daughter of one of the others. Sir Barnacle's yacht is the Gabrielle, Mr. Moore owns the Lorna; Mr. Hall the Rosalind. The Melissa, owned by Colonel Downing, is named after Sir Barnacle's daughter. Gabrielle's father owns the yacht that is named after Dr. Parker's daughter. Who is Lorna's father?
;;
;; Try to write the program so that it runs efficiently (see exercise 4.40). Also determine how many solutions there are if we are not told that Mary Ann's last name is Moore.

;;; Answer
(define yachts
  '(let ((yacht (lambda (father)
                  (cond ((eq? father 'barnacle) 'gabrielle)
                        ((eq? father 'moore) 'lorna)
                        ((eq? father 'hall) 'rosalind)
                        ((eq? father 'downing) 'melissa)
                        ((eq? father 'parker) 'mary-ann)))))
     (let ((moore (amb 'gabrielle 'lorna 'rosalind 'melissa 'mary-ann))
           (barnacle (amb 'gabrielle 'lorna 'rosalind 'melissa 'mary-ann))
           (hall (amb 'gabrielle 'lorna 'rosalind 'melissa 'mary-ann))
           (downing (amb 'gabrielle 'lorna 'rosalind 'melissa 'mary-ann))
           (parker (amb 'gabrielle 'lorna 'rosalind 'melissa 'mary-ann)))
       ;; Given
       (require (eq? moore 'mary-ann))
       (require (eq? barnacle 'melissa))
       ;; Yachts
       (require (not (eq? hall (yacht 'hall))))
       (require (not (eq? downing (yacht 'downing))))
       (require (not (eq? parker (yacht 'parker))))
       ;; Logical tests
       (require (distinct? (list barnacle moore hall downing parker)))
       (require (cond ((eq? hall 'gabrielle) (eq? parker (yacht 'hall)))
                      ((eq? downing 'gabrielle) (eq? parker (yacht 'downing)))
                      ((eq? parker 'gabrielle) (eq? parker (yacht 'parker)))))
       (list (list 'barnacle barnacle)
             (list 'moore moore)
             (list 'hall hall)
             (list 'downing downing)
             (list 'parker parker)))))
(define yachts-omit
  '(let ((yacht (lambda (father)
                  (cond ((eq? father 'barnacle) 'gabrielle)
                        ((eq? father 'moore) 'lorna)
                        ((eq? father 'hall) 'rosalind)
                        ((eq? father 'downing) 'melissa)
                        ((eq? father 'parker) 'mary-ann)))))
     (let ((moore (amb 'gabrielle 'lorna 'rosalind 'melissa 'mary-ann))
           (barnacle (amb 'gabrielle 'lorna 'rosalind 'melissa 'mary-ann))
           (hall (amb 'gabrielle 'lorna 'rosalind 'melissa 'mary-ann))
           (downing (amb 'gabrielle 'lorna 'rosalind 'melissa 'mary-ann))
           (parker (amb 'gabrielle 'lorna 'rosalind 'melissa 'mary-ann)))
       ;; Given
       ;; (require (eq? moore 'mary-ann))
       (require (eq? barnacle 'melissa))
       ;; Yachts
       (require (not (eq? hall (yacht 'hall))))
       (require (not (eq? downing (yacht 'downing))))
       (require (not (eq? parker (yacht 'parker))))
       ;; Logical tests
       (require (distinct? (list barnacle moore hall downing parker)))
       (require (cond ((eq? hall 'gabrielle) (eq? parker (yacht 'hall)))
                      ((eq? downing 'gabrielle) (eq? parker (yacht 'downing)))
                      ((eq? parker 'gabrielle) (eq? parker (yacht 'parker)))))
       (list (list 'barnacle barnacle)
             (list 'moore moore)
             (list 'hall hall)
             (list 'downing downing)
             (list 'parker parker)))))

;; Test
(load "4.amb.scm")
(print-amb yachts)
(print "Omitting Mary Ann's last name")
(print-amb yachts-omit)
