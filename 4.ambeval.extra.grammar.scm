(mc-eval
 '(begin
    ;; Data
    (define nouns
      '(noun
        student professor cat class))
    (define verbs
      '(verb
        studies lectures eats sleeps))
    (define articles
      '(article
        the a an))
    (define prepositions
      '(prep
        for to in by with))
    ;; Proc
    (define (parse-sentence)
      (list 'sentence
            (parse-noun-phrase)
            (parse-verb-phrase)))
    (define (parse-simple-noun-phrase)
      (list 'simple-noun-phrase
            (parse-word articles)
            (parse-word nouns)))
    (define (parse-noun-phrase)
      (let maybe-extend ((noun-phrase (parse-simple-noun-phrase)))
        (amb noun-phrase
             (maybe-extend (list 'noun-phrase
                                 noun-phrase
                                 (parse-prepositional-phrase))))))
    (define (parse-verb-phrase)
      (let maybe-extend ((verb-phrase (parse-word verbs)))
        (amb verb-phrase
             (maybe-extend (list 'verb-phrase
                                 verb-phrase
                                 (parse-prepositional-phrase))))))
    (define (parse-prepositional-phrase)
      (list 'prep-phrase
            (parse-word prepositions)
            (parse-noun-phrase)))
    ;; Main
    (define *unparsed* '())
    (define (class word-list)
      (car word-list))
    (define (words word-list)
      (cdr word-list))
    (define (parse-word word-list)
      (require (not (null? *unparsed*)))
      (require (memq (car *unparsed*) (words word-list)))
      (let ((found-word (car *unparsed*)))
        (set! *unparsed* (cdr *unparsed*))
        (list (class word-list) found-word)))
    (define (parse input)
      (set! *unparsed* input)
      (let ((sent (parse-sentence)))
        (require (null? *unparsed*))
        sent))))
