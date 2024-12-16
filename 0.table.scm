;; SICP procs
(define (put op type proc)
  (hash-table/put! *op-table* (list op type) proc))
(define (get op type)
  (hash-table/get *op-table* (list op type) false))
;; Table abstraction
(define (table-make)
  (make-hash-table))
(define (table-put table key val)
  (hash-table/put! table key val))
(define (table-get table key)
  (hash-table/get table key false))
(define (table-put-append-list table key val)
  (let ((val-list (table-get table key)))
    (if val-list
        (when (not (member val val-list))
          (table-put table key (cons val val-list)))
        (table-put table key (list val)))))
