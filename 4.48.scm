;;;; 4.48
;; Extend the grammar given above to handle more complex sentences. For example, you could extend noun phrases and verb phrases to include adjectives and adverbs, or you could handle compound sentences.

;;; Answer
(define direct-object
  '(define (parse-verb-phrase)
     (define (maybe-extend verb-phrase)
       (amb verb-phrase
            (maybe-extend-object (list 'verb-phrase
                                       verb-phrase
                                       (parse-noun-phrase))) ; Direct object
            (maybe-extend (list 'verb-phrase
                                verb-phrase
                                (parse-prepositional-phrase)))))
     (define (maybe-extend-object verb-phrase)
       (amb verb-phrase
            (maybe-extend-object (list 'verb-phrase
                                       verb-phrase
                                       (parse-prepositional-phrase)))))
     (maybe-extend (parse-word verbs))))

;; Test
(load "4.amb.scm")
(global-eval '(load "4.amb.example.grammar.recursive.scm"))
(global-eval '(define nouns '(noun student professor cat class apple)))
(global-eval direct-object)
(print-amb '(parse '(the professor eats an apple in the class)))
;; 1. Professor eats an apple in the classroom
;; (sentence
;;   (simple-noun-phrase (article the) (noun professor))
;;   (verb-phrase (verb-phrase (verb eats)
;;                             (simple-noun-phrase (article an) (noun apple)))
;;                (prep-phrase (prep in)
;;                             (simple-noun-phrase (article the) (noun class)))))
;;
;; 2. Professor eats an apple located in the classroom
;; (sentence
;;   (simple-noun-phrase (article the) (noun professor))
;;   (verb-phrase (verb eats)
;;                (noun-phrase (simple-noun-phrase (article an) (noun apple))
;;                             (prep-phrase (prep in)
;;                                          (simple-noun-phrase (article the) (noun class))))))
