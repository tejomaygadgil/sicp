(define (install-conjoin-package)
  ;; Sel
  (define (first-conjunct exps) (car exps))
  (define (rest-conjuncts exps) (cdr exps))
  ;; Pred
  (define (empty-conjunction? exps) (null? exps))
  ;; Proc
 (define (merge-frames f1 f2) ; cf. poly @ http://community.schemewiki.org/?sicp-ex-4.76
   (cond ((null? f1) f2)
         ((eq? 'failed f2) 'failed)
         (else
           (merge-frames (cdr f1)
                         (extend-if-possible
                           (binding-variable (car f1))
                           (binding-value (car f1))
                           f2)))))
  (define (merge-frame-streams sf1 sf2)
    (stream-flatmap
      (lambda (x)
        (stream-flatmap
          (lambda (y)
            (let ((res (merge-frames x y)))
              (if (eq? res 'failed)
                  the-empty-stream
                  (singleton-stream res))))
          sf2))
      sf1))
  (define (conjoin conjuncts frame-stream)
      (if (empty-conjunction? conjuncts)
          frame-stream
          (merge-frame-streams
            (qeval (first-conjunct conjuncts) frame-stream)
            (conjoin (rest-conjuncts conjuncts) frame-stream))))
  ;; Install
  (put 'and 'qeval conjoin)
  'ok)
