;; Sel
(define (stream-car stream)
  (car stream))
(define (stream-cdr stream)
  (force (cdr stream)))
(define (stream-ref s n)
  (cond ((< n 0) (error "Negative index -- STREAM-REF" n))
        ((= n 0) (stream-car s))
        (else (stream-ref (stream-cdr s) (- n 1)))))
;; Proc
(define (stream-enumerate-interval low high)
  (if (> low high) the-empty-stream
    (cons-stream
      low
      (stream-enumerate-interval (1+ low) high))))
(define (stream-filter pred stream)
  (cond ((null? stream) the-empty-stream)
        ((pred (stream-car stream))
         (cons-stream
           (stream-car stream)
           (stream-filter pred (stream-cdr stream))))
        (else (stream-filter pred (stream-cdr stream)))))
;; (define (stream-map proc s)
;;   (if (null? s) the-empty-stream
;;     (cons-stream
;;       (proc (stream-car s))
;;       (stream-map proc (stream-cdr s)))))
(load "3.50.stream-map.scm")
(define (stream-for-each proc s)
  (if (null? s) 'done
    (begin
      (proc (stream-car s))
      (stream-for-each proc (stream-cdr s)))))
(define (stream-append s1 s2)
  (if (stream-null? s1)
      s2
      (cons-stream (stream-car s1)
                   (stream-append (stream-cdr s1) s2))))
;; Display
(define (display-stream s)
  (stream-for-each display-line s))
(define (display-line x)
  (newline)
  (display x))
(define (display-n s a b)
  (newline)
  (let iter ((i a))
    (if (< i b)
      (begin
        (display-line (stream-ref s i))
        (iter (+ i 1))))))
