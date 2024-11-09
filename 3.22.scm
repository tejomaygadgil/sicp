;;;; 3.22
;; Instead of representing a queue as a pair of pointers, we can build a queue as a procedure with local state. The local state will consist of pointers to the beginning and the end of an ordinary list. Thus, the make-queue procedure will have the form
;;
;; (define (make-queue)
;;     (let ((front-ptr ...)
;;           (rear-ptr ...))
;;       <definitions of internal procedures>
;;       (define (dispatch m) ...)
;;       dispatch))
;;
;; Complete the definition of `make-queue` and provide implementations of the queue operations using this representation.

;; Test
(load "0.util.scm")
(load "3.22.queue.scm")
;; Test
(define q1 (make-queue))
(test (empty-queue? q1) #t)
(insert-queue! q1 1) (test (front-queue q1) 1)
(insert-queue! q1 2)
(test (front-queue q1) 1)
(insert-queue! q1 3)
(test (front-queue q1) 1)
(test (empty-queue? q1) #f)
(delete-queue! q1)
(test (front-queue q1) 2)
(delete-queue! q1)
(test (front-queue q1) 3)
(delete-queue! q1)
(test (empty-queue? q1) #t)
