;;;; 4.49
;; Alyssa P. Hacker is more interested in generating interesting sentences than in parsing them. She reasons that by simply changing the procedure `parse-word` so that it ignores the "input sentence" and instead always succeeds and generates an appropriate word, we can use the programs we had built for parsing to do generation instead. Implement Alyssa's idea, and show the first half-dozen or so sentences generated.

;;; Answer
(define generator
  '(define (parse-word word-list)
       (list (car word-list)
             (an-element-of (cdr word-list)))))

;; Test
(load "4.amb.scm")
(global-eval '(load "4.amb.example.grammar.recursive.scm"))
(global-eval generator)
(let ((a1 (amb-global-eval '(parse-sentence))))
  (let iter ((i 1))
    (if (< i 7)
      (begin (display i)
             (display ": ")
             (print (next-val a1))
             (iter (1+ i))))))
;; The sentences recursing the first verb phrase.
