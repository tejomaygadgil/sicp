(define (make-table)
  (let ((local-table (list '*table*)))
    ;; Proc
    (define (assoc key records)
      (cond ((null? records) false)
            ((equal? key (caar records)) (car records))
            (else (assoc key (cdr records)))))
    ;; Sel
    (define (lookup keys)
      (let iter ((table local-table)
                 (keys keys))
        (let ((first-key (car keys))
              (rest-keys (cdr keys)))
          (let ((record (assoc first-key
                               (cdr table))))
            (if record
              (if (null? rest-keys) (cdr record)
                (iter record rest-keys))
              false)))))
    ;; Mut
    (define (add-to-table! table value)
      (set-cdr! table (cons value (cdr table))))
    (define (insert! keys value)
      (let iter ((table local-table)
                 (keys keys))
        (let ((first-key (car keys))
              (rest-keys (cdr keys)))
          (let ((record (assoc first-key
                               (cdr table))))
            (if record
              (if (null? rest-keys)
                (set-cdr! record value) ; Base case: update value
                (iter record rest-keys))
              (if (null? rest-keys)
                (add-to-table! table (cons first-key value)) ; Base case: new table
                (begin
                  (add-to-table! table (cons first-key '()))
                  (iter (cadr table) rest-keys)))))) ; Reduction: create table and iterate
        'ok))
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            (else (error "Unknown operation -- TABLE" m))))
    dispatch))
;; Interface
(define (get table keys)
  ((table 'lookup-proc) keys))
(define (put table keys value)
  ((table 'insert-proc!) keys value))
