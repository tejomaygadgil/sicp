(define (stream-map proc . argstreams)
  (if (any empty-stream? argstreams) the-empty-stream
    (cons-stream (apply proc (map stream-car argstreams))
                 (apply stream-map (cons proc (map stream-cdr argstreams))))))
