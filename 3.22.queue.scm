(define (make-queue)
  (let ((front-ptr '())
        (rear-ptr '()))
    ;; Sel
    (define (front-queue)
      (if (empty-queue?)
        (error "FRONT called with an empty queue")
        (car front-ptr)))
    ;; Pred
    (define (empty-queue?) (null? front-ptr))
    ;; Mut
    (define (set-front-ptr! item) (set! front-ptr item))
    (define (set-rear-ptr! item) (set! rear-ptr item))
    (define (insert-queue! item)
      (let ((new-pair (cons item '())))
        (cond ((empty-queue?)
               (set-front-ptr! new-pair)
               (set-rear-ptr! new-pair))
              (else
               (set-cdr! rear-ptr new-pair)
               (set-rear-ptr! new-pair)))
        'ok))
    (define (delete-queue!)
      (cond ((empty-queue?)
             (error "DELETE! called with an empty queue"))
            (else
              (set-front-ptr! (cdr front-ptr))
              front-ptr)))
    (define (dispatch m)
      (cond ((eq? m 'empty-queue?) (empty-queue?))
            ((eq? m 'front-queue) (front-queue))
            ((eq? m 'insert-queue!) insert-queue!)
            ((eq? m 'delete-queue!) (delete-queue!))
            (else (error "Unknown request -- MAKE-QUEUE" m))))
    dispatch))
;; Interface
;; Sel
(define (front-queue queue)
  (queue 'front-queue))
;; Pred
(define (empty-queue? queue)
  (queue 'empty-queue?))
;; Mut
(define (insert-queue! queue item)
  ((queue 'insert-queue!) item))
(define (delete-queue! queue)
  (queue 'delete-queue!))
