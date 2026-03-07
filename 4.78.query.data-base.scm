(define (initialize-data-base rules-and-assertions)
  (define (deal-out r-and-a rules assertions)
    (cond ((null? r-and-a)
           (set! THE-ASSERTIONS assertions)
           (set! THE-RULES rules)
           'done)
          (else
           (let ((s (query-syntax-process (car r-and-a))))
             (cond ((rule? s)
                    (store-rule-in-index s)
                    (deal-out (cdr r-and-a)
                              (cons s rules)
                              assertions))
                   (else
                    (store-assertion-in-index s)
                    (deal-out (cdr r-and-a)
                              rules
                              (cons s assertions))))))))
  (deal-out rules-and-assertions '() '()))

(define (get-r-a key1 key2)
  (let ((s (get key1 key2)))
    (if s s '())))

(define (fetch-assertions pattern frame)
  (let ((assertions (if (use-index? pattern)
                        (get-indexed-assertions pattern)
                        (get-all-assertions))))
    (an-element-of assertions)))

(define (get-all-assertions) THE-ASSERTIONS)

(define (get-indexed-assertions pattern)
  (get-r-a (index-key-of pattern) 'assertions))

(define (fetch-rules pattern frame)
  (an-element-of
   (if (use-index? pattern)
       (get-indexed-rules pattern)
       (get-all-rules))))

(define (get-all-rules) THE-RULES)

(define (get-indexed-rules pattern)
  (append
   (get-r-a (index-key-of pattern) 'rules)
   (get-r-a '? 'rules)))

(define (add-assertion! assertion)
  (store-assertion-in-index assertion)
  (let ((old-assertions THE-ASSERTIONS))
    (set! THE-ASSERTIONS
          (cons assertion old-assertions))
    'ok))

(define (add-rule! rule)
  (store-rule-in-index rule)
  (let ((old-rules THE-RULES))
    (set! THE-RULES (cons rule old-rules))
    'ok))

(define (store-assertion-in-index assertion)
  (if (indexable? assertion)
      (let ((key (index-key-of assertion)))
        (let ((current-assertions
               (get-r-a key 'assertions)))
          (put key
               'assertions
               (cons assertion
                     current-assertions))))))

(define (store-rule-in-index rule)
  (let ((pattern (conclusion rule)))
    (if (indexable? pattern)
        (let ((key (index-key-of pattern)))
          (let ((current-rules
                 (get-r-a key 'rules)))
            (put key
                 'rules
                 (cons rule
                       current-rules)))))))

(define (indexable? pat)
  (or (constant-symbol? (car pat))
      (var? (car pat))))

(define (index-key-of pat)
  (let ((key (car pat)))
    (if (var? key) '? key)))

(define (use-index? pat)
  (constant-symbol? (car pat)))

(define (var? exp)
  (tagged-list? exp '?))

(define (constant-symbol? exp)
  (symbol? exp))
