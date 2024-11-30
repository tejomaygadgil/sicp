;; Sel
(define (fetch-assertions pattern frame)
  (define (get-all-assertions) THE-ASSERTIONS)
  (define (get-indexed-assertions pattern)
    (get-stream (index-key-of pattern) 'assertion-stream))
  (if (use-index? pattern)
      (get-indexed-assertions pattern)
      (get-all-assertions)))
;; Proc
(define (store-assertion-in-index assertion)
  (if (indexable? assertion)
      (let ((key (index-key-of assertion)))
        (let ((current-assertion-stream
               (get-stream key 'assertion-stream)))
          (put key
               'assertion-stream
               (cons-stream assertion
                            current-assertion-stream))))))
;; Mut
(define (add-assertion! assertion)
  (store-assertion-in-index assertion)
  (let ((old-assertions THE-ASSERTIONS))
    (set! THE-ASSERTIONS
          (cons-stream assertion old-assertions))
    'ok))
;; Obj
(define THE-ASSERTIONS the-empty-stream)
