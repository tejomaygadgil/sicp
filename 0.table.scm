(define (put table op type proc) (hash-table/put! table (list op type) proc))
(define (get table op type) (hash-table/get table (list op type) false))
