;; Sel
(define (fetch-rules pattern frame)
  (define (get-all-rules) THE-RULES)
  (define (get-indexed-rules pattern)
    (stream-append
     (get-stream (index-key-of pattern) 'rule-stream)
     (get-stream '? 'rule-stream)))
  (if (use-index? pattern)
      (get-indexed-rules pattern)
      (get-all-rules)))
;; Proc
(define (store-rule-in-index rule)
  (let ((pattern (conclusion rule)))
    (if (indexable? pattern)
        (let ((key (index-key-of pattern)))
          (let ((current-rule-stream
                 (get-stream key 'rule-stream)))
            (put key
                 'rule-stream
                 (cons-stream rule
                              current-rule-stream)))))))
;; Mut
(define (add-rule! rule)
  (store-rule-in-index rule)
  (let ((old-rules THE-RULES))
    (set! THE-RULES (cons-stream rule old-rules))
    'ok))
;; Obj
(define THE-RULES the-empty-stream)
