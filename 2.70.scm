;;;; 2.70
;; The following eight-symbol alphabet with associated relative frequencies was designed to efficiently encode the lyrics of 1950s rock songs. (Note that the "symbols" of an "alphabet" need not be individual letters.)
;;
;; A    2 NA   16
;; BOOM 1 SHA  3
;; GET  2 YIP  9
;; JOB  2 WAH  1
;;
;; Use `generate-huffman-tree` (exercise 2.69) to generate a corresponding Huffman tree, and use `encode` (exercise 2.68) to encode the following message:
;;
;; Get a job
;;
;; Sha na na na na na na na na
;;
;; Get a job
;;
;; Sha na na na na na na na na
;;
;; Wah yip yip yip yip yip yip yip yip yip
;;
;; Sha boom
;;
;; How many bits are required for the encoding? What is the smallest number of bits that would be needed to encode this song if we used a fixed-length code for the eight-symbol alphabet?

;;; Answer
(load "0.util.scm")
(load "2.69.scm")
(define rock-n-roll (list (list 'A 2) (list 'NA 16)
                          (list 'BOOM 1) (list 'SHA 3)
                          (list 'GET 2) (list 'YIP 9)
                          (list 'JOB 2) (list 'WAH 1)))
(define rock-n-roll-tree (generate-huffman-tree rock-n-roll))
(define messages '((GET A JOB)
                   (SHA NA NA NA NA NA NA NA NA)
                   (GET A JOB)
                   (SHA NA NA NA NA NA NA NA NA)
                   (WAH YIP YIP YIP YIP YIP YIP YIP YIP YIP)
                   (SHA BOOM)))
(define encoded-messages (map (lambda (x) (encode x rock-n-roll-tree)) messages))
(map print encoded-messages)
(display (apply + (map length encoded-messages))) (display " bits") (newline)

;; rock-n-roll-tree
;;    36
;;   / \
;; na   20
;;     / \
;;   yip  11
;;       / \
;;      4   ----7
;;     / \     / \
;;    a   2  sha  4
;;       / \     / \
;;    wah boom job get

;; We save ~23% with variable-length encoding: Huffman encoding takes up 84 bits.
;; Fixed-length encoding takes up 36 tokens * 3 bits = 108 bits (3 bits for 8 characters).
