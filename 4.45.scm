;;;; 4.45
;; With the grammar given above, the following sentence can be parsed in five different ways: "The professor lectures to the student in the class with the cat." Give the five parses and explain the differences in shades of meaning among them.

;;; Answer
(load "4.amb.scm")
(global-eval '(load "4.amb.example.grammar.recursive.scm"))
(print-amb '(parse '(the professor lectures to the student in the class with the cat)))
;; 1. Professor lectures to the student, this is in a classroom, this alongside a feline colleague.
;; (sentence
;;   (simple-noun-phrase (article the) (noun professor))
;;   (verb-phrase
;;     (verb-phrase
;;       (verb-phrase (verb lectures)
;;                    (prep-phrase (prep to)
;;                                 (simple-noun-phrase (article the) (noun student))))
;;       (prep-phrase (prep in)
;;                    (simple-noun-phrase (article the) (noun class))))
;;     (prep-phrase (prep with)
;;                  (simple-noun-phrase (article the) (noun cat)))))
;;
;; 2. Professor lectures to the student, this is in a classroom that has a cat in it.
;; (sentence
;;   (simple-noun-phrase (article the) (noun professor))
;;   (verb-phrase
;;     (verb-phrase (verb lectures)
;;                  (prep-phrase (prep to)
;;                               (simple-noun-phrase (article the) (noun student))))
;;     (prep-phrase (prep in)
;;                  (noun-phrase
;;                    (simple-noun-phrase (article the) (noun class))
;;                    (prep-phrase (prep with)
;;                                 (simple-noun-phrase (article the) (noun cat)))))))
;;
;; 3. Professor lectures to the student who is in a classroom, alongside a feline colleague.
;; (sentence
;;   (simple-noun-phrase (article the) (noun professor))
;;   (verb-phrase
;;     (verb-phrase (verb lectures)
;;                  (prep-phrase (prep to)
;;                               (noun-phrase
;;                                 (simple-noun-phrase (article the) (noun student))
;;                                 (prep-phrase (prep in)
;;                                              (simple-noun-phrase (article the) (noun class))))))
;;     (prep-phrase (prep with)
;;                  (simple-noun-phrase (article the) (noun cat)))))
;;
;; 4. Professor lectures to the student who is in a classroom, alongside a feline classmate.
;; (sentence
;;   (simple-noun-phrase (article the) (noun professor))
;;   (verb-phrase (verb lectures)
;;                (prep-phrase (prep to)
;;                             (noun-phrase
;;                               (noun-phrase
;;                                 (simple-noun-phrase (article the) (noun student))
;;                                 (prep-phrase (prep in)
;;                                              (simple-noun-phrase (article the) (noun class))))
;;                               (prep-phrase (prep with)
;;                                            (simple-noun-phrase (article the) (noun cat)))))))
;;
;; 5. Professor lectures to the student who is in a classroom that has a cat in it.
;; (sentence
;;   (simple-noun-phrase (article the) (noun professor))
;;   (verb-phrase (verb lectures)
;;                (prep-phrase (prep to)
;;                             (noun-phrase
;;                               (simple-noun-phrase (article the) (noun student))
;;                               (prep-phrase (prep in)
;;                                            (noun-phrase
;;                                              (simple-noun-phrase (article the) (noun class))
;;                                              (prep-phrase (prep with)
;;                                                           (simple-noun-phrase (article the) (noun cat)))))))))
