;;;; 2.68
;; The `encode` procedure takes as arguments a message and a tree and produces the list of bits that gives the encoded message.

(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

;; `Encode-symbol` is a procedure, which you must write, that returns the list of bits that encodes a given symbol according to a given tree. You should design `encode-symbol` so that it signals an error if the symbol is not in the tree at all. Test your procedure by encoding the result you obtained in exercise 2.67 with the sample tree and seeing whether it is the same as the original sample message.

;;; Answer
(load "2.huffman.scm")
(load "2.59.scm") ; Unordered-list set
(define (encode-symbol symbol tree)
  (let ((left-branch (left-branch tree)) 
        (right-branch (right-branch tree)))
    (cond ((element-of-set? symbol (symbols left-branch))
           (if (leaf? left-branch) (list 0)
             (cons 0 (encode-symbol symbol left-branch))))
          ((element-of-set? symbol (symbols right-branch))
           (if (leaf? right-branch) (list 1)
             (cons 1 (encode-symbol symbol right-branch))))
          (else (error "Not in tree:" symbol)))))

;; ;; Test
;; (load "0.util.scm")
;; (load "2.67.scm")
;; (test (encode (decode sample-message sample-tree) sample-tree) sample-message)
;; (test (decode (encode answer sample-tree) sample-tree) answer)
