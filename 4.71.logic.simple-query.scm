(define (simple-query query-pattern frame-stream)
  (define (find-assertions pattern frame)
    (display-line "Finding assertions... ")
    (display pattern)
    (stream-flatmap (lambda (datum)
                      (check-an-assertion datum pattern frame))
                    (fetch-assertions pattern frame)))
  (define (check-an-assertion assertion query-pat query-frame)
    (let ((match-result
           (pattern-match query-pat assertion query-frame)))
      (if (eq? match-result 'failed)
          the-empty-stream
          (singleton-stream match-result))))
  (stream-flatmap
   (lambda (frame)
     (stream-append
      (find-assertions query-pattern frame)
      (apply-rules query-pattern frame)))
   frame-stream))
