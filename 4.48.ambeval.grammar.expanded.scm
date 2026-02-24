(mc-eval
 '(begin
    (define nouns (append nouns '(apple)))
    (define verbs (append verbs '(reads)))
    (define conjunctions '(conjunction and or but if because although while))
    (define (parse-verb-phrase)
      (define (maybe-extend verb-phrase)
        (amb verb-phrase
             (maybe-extend (list 'verb-phrase
                                 verb-phrase
                                 (parse-noun-phrase)))
             (maybe-extend (list 'verb-phrase
                                 verb-phrase
                                 (parse-prepositional-phrase))))) ;; Direct object
      (maybe-extend (parse-word verbs)))
    (define (parse-sentence)
      (let maybe-extend ((sentence-phrase
                          (list 'sentence
                                (parse-noun-phrase)
                                (parse-verb-phrase))))
        (amb sentence-phrase
             (maybe-extend (list (parse-conjunction)
                                 sentence-phrase
                                 (parse-sentence))))))
    (define (parse-conjunction)
      (parse-word conjunctions))))
