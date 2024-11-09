;;;; 3.23
;; A deque ("double-ended queue") is a sequence in which items can be inserted and deleted at either the front or the rear. Operations on deques are the constructor `make-deque`, the predicate `empty-deque?`, selectors `front-deque` and `rear-deque`, and mutators `front-insert-deque!`, `rear-insert-deque!`, `front-delete-deque!`, and `rear-delete-deque!`. Show how to represent deques using pairs, and give implementations of the operations. All operations should be accomplished in $\Theta(1)$ steps.

;;; Answer
;; We implement deque using a doubly-linked list
(define (make-deque)
  (let ((the-empty-pointer '()))
    (let ((front-ptr the-empty-pointer)
          (rear-ptr the-empty-pointer))
      ;; Node abstraction
      (include "3.23.node.scm")
      ;; Pred
      (define (empty-deque?)
        (eq? front-ptr the-empty-pointer))
      (define (same-ptrs?)
        (eq? front-ptr rear-ptr))
      ;; Sel
      (define (front-deque)
        (if (empty-deque?)
          (error "FRONT called with an empty deque")
          (value front-ptr)))
      (define (rear-deque)
        (if (empty-deque?)
          (error "REAR called with an empty deque")
          (value rear-ptr)))
      ;; Mut
      (define (set-front-ptr! item) 
        (set! front-ptr item))
      (define (set-rear-ptr! item) 
        (set! rear-ptr item))
      (define (set-both-ptrs! item)
        (set-front-ptr! item)
        (set-rear-ptr! item))
      (define (front-insert-deque! value)
        (let ((node (make-node value)))
          (if (empty-deque?)
            (set-both-ptrs! node)
            (begin
              (link-nodes! node front-ptr)
              (set-front-ptr! node)))))
      (define (rear-insert-deque! value)
        (let ((node (make-node value)))
          (if (empty-deque?)
            (set-both-ptrs! node)
            (begin
              (link-nodes! rear-ptr node)
              (set-rear-ptr! node)))))
      (define (front-delete-deque!)
        (cond ((empty-deque?)
               (error "FRONT-DELETE! called with an empty deque"))
              ((same-ptrs?)
               (set-both-ptrs! the-empty-pointer))
              (else
                (set-front-ptr! (next front-ptr)))))
      (define (rear-delete-deque!)
        (cond ((empty-deque?)
               (error "REAR-DELETE! called with an empty deque"))
              ((same-ptrs?)
               (set-both-ptrs! the-empty-pointer))
              (else
                (set-rear-ptr! (prev rear-ptr)))))
      ;; Dispatch
      (define (dispatch m)
        (cond ((eq? m 'empty-deque?) (empty-deque?))
              ((eq? m 'front-deque) (front-deque))
              ((eq? m 'rear-deque) (rear-deque))
              ((eq? m 'front-insert-deque!) front-insert-deque!)
              ((eq? m 'front-delete-deque!) (front-delete-deque!))
              ((eq? m 'rear-insert-deque!) rear-insert-deque!)
              ((eq? m 'rear-delete-deque!) (rear-delete-deque!))
              (else (error "Unknown command" m))))
      dispatch)))
;; Interface
;; Sel
(define (front-deque deque)
  (deque 'front-deque))
(define (rear-deque deque)
  (deque 'rear-deque))
;; Pred
(define (empty-deque? deque)
  (deque 'empty-deque?))
;; Mut
(define (front-insert-deque! deque item)
  ((deque 'front-insert-deque!) item))
(define (rear-insert-deque! deque item)
  ((deque 'rear-insert-deque!) item))
(define (front-delete-deque! deque)
  (deque 'front-delete-deque!))
(define (rear-delete-deque! deque)
  (deque 'rear-delete-deque!))

;; Test
(load "0.util.scm")
(define d1 (make-deque))
(define d2 (make-deque))
;; Test rear insert
(test (empty-deque? d1) #t)
;; RI 1
(rear-insert-deque! d1 1)
(test (front-deque d1) 1)
(test (rear-deque d1) 1)
(test (empty-deque? d1) false)
;; Test front insert
(test (empty-deque? d2) #t)
;; FI 1
(front-insert-deque! d2 1)
(test (front-deque d2) 1)
(test (rear-deque d2) 1)
(test (empty-deque? d2) false)
;; FI 0
(front-insert-deque! d2 0)
(test (front-deque d2) 0)
(test (rear-deque d2) 1)
(test (empty-deque? d2) false)
;; FI -1
(front-insert-deque! d2 -1)
(test (front-deque d2) -1)
(test (rear-deque d2) 1)
(test (empty-deque? d2) false)
;; RI 2
(rear-insert-deque! d2 2)
(test (front-deque d2) -1)
(test (rear-deque d2) 2)
(test (empty-deque? d2) false)
;; FD -1
(front-delete-deque! d2)
(test (front-deque d2) 0)
(test (rear-deque d2) 2)
(test (empty-deque? d2) false)
;; FD 0
(front-delete-deque! d2)
(test (front-deque d2) 1)
(test (rear-deque d2) 2)
(test (empty-deque? d2) false)
;; RD 2
(rear-delete-deque! d2)
(test (front-deque d2) 1)
(test (rear-deque d2) 1)
(test (empty-deque? d2) false)
;; RD 1
(rear-delete-deque! d2)
(test (empty-deque? d2) true)
