;; Inherit
(load "4.query.scm")
;; Modify (cf. poly's solution http://community.schemewiki.org/?sicp-ex-4.76)
(define (conjoin conjuncts frame-stream)
  (if (empty-conjunction? conjuncts)
      frame-stream
      (if (mergeable? conjuncts)
          (begin
            (newline)
            (display "(Merging frame streams)")
            (merge-frame-streams
             (qeval (first-conjunct conjuncts) frame-stream)
             (conjoin (rest-conjuncts conjuncts) frame-stream)))
          (conjoin (rest-conjuncts conjuncts)
                   (qeval (first-conjunct conjuncts)
                          frame-stream)))))
(define (mergeable? conjuncts)
  (if (null? conjuncts) true
      (if (member (type (first-conjunct conjuncts))
                  '(not lisp-value)) false
                  (mergeable? (rest-conjuncts conjuncts)))))
(define (merge-frame-streams frame-stream-1 frame-stream-2)
  (stream-flatmap
   (lambda (x)
     (stream-flatmap
      (lambda (y)
        (let ((res (merge-frames x y)))
          (if (eq? res 'failed) the-empty-stream
              (singleton-stream res))))
      frame-stream-2))
   frame-stream-1))
(define (merge-frames frame-1 frame-2)
  (cond ((null? frame-1) frame-2)
        ((eq? 'failed frame-2) 'failed)
        (else
         (merge-frames (cdr frame-1)
                       (extend-if-possible
                        (binding-variable (car frame-1))
                        (binding-value (car frame-1))
                        frame-2)))))
