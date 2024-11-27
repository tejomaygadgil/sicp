;;;; 4.50
;; Implement a new special form `ramb` that is like `amb` except that it searches alternatives in a random order, rather than from left to right. Show how this can help with Alyssa's problem in exercise 4.49.


;;; Answer
(define random-generator
  '(define (parse-word word-list)
       (list (car word-list)
             (random-element (cdr word-list))))) ; Changed

;; Test
(load "4.amb.scm")
(load "4.50.ramb.scm")
(install-ramb-package)
(install-random-element)
(global-eval '(load "4.amb.example.grammar.recursive.scm"))
(global-eval random-generator)
(let iter ((i 1))
  (let ((a1 (amb-global-eval '(parse-sentence)))) ; New calls traverse a new random tree
    (if (< i 7)
      (begin (display i)
             (display ": ")
             (print (next-val a1))
             (print (next-val a1))
             (print (next-val a1))
             (iter (1+ i))))))
