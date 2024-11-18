;;;; 3.50
;; Complete the following definition, which generalizes `stream-map` to allow procedures that take multiple arguments, analogous to map in section 2.2.3, footnote 12.
;;
;; (define (stream-map proc . argstreams)
;;   (if (<??> (car argstreams))
;;       the-empty-stream
;;       (<??>
;;        (apply proc (map <??> argstreams))
;;        (apply stream-map
;;               (cons proc (map <??> argstreams))))))

;; Test
(load "0.util.scm")
(load "3.streams.scm")
(define s1 (stream-enumerate-interval 10 20))
(define s2 (stream-enumerate-interval 20 30))
(define sum (stream-map + s1 s2))
(test (stream-ref sum 0) 30)
(test (stream-ref sum 1) 32)
(test (stream-ref sum 2) 34)
(test (stream-ref sum 3) 36)
(test (stream-ref sum 4) 38)
(test (stream-ref sum 5) 40)
(test (stream-ref sum 6) 42)
(test (stream-ref sum 7) 44)
