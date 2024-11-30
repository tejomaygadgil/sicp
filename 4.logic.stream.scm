;; Sel
(define (get-stream key1 key2)
  (let ((s (get key1 key2)))
    (if s s the-empty-stream)))
;; Proc
(define (stream-append-delayed s1 delayed-s2)
  (if (stream-null? s1)
      (force delayed-s2)
      (cons-stream
       (stream-car s1)
       (stream-append-delayed (stream-cdr s1) delayed-s2))))
(define (stream-flatmap proc s)
  (let flatten-stream ((stream (stream-map proc s)))
    (if (stream-null? stream)
        the-empty-stream
        (interleave-delayed
         (stream-car stream)
         (delay (flatten-stream (stream-cdr stream)))))))
  (define (interleave-delayed s1 delayed-s2)
    (if (stream-null? s1)
        (force delayed-s2)
        (cons-stream
         (stream-car s1)
         (interleave-delayed (force delayed-s2)
                             (delay (stream-cdr s1))))))
(define (singleton-stream x)
  (cons-stream x the-empty-stream))
;; Obj
(define the-empty-frame-stream
  (singleton-stream the-empty-frame))
