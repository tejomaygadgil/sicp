(define (make-table less-than? greater-than? equal-to?)
  (let ((local-table (list '*table*)))
    ;; Binary search tree abstraction
    (include "2.binary-tree.scm")
    ;; Record abstraction
    ;; Sel
    (define (key record) (car record))
    (define (value record) (cdr record))
    ;; Cons
    (define (make-record key value) (cons key value))
    ;; Proc
    (define (assoc given-key set-of-records) ; cf. lookup (2.66.lookup.scm)
      (cond ((null? set-of-records) false)
            ((equal-to? given-key (key (car set-of-records))) ; Changed
             (car set-of-records))
            ((less-than? given-key (key (car set-of-records))) ; Changed
             (assoc given-key (left-branch set-of-records)))
            (else
             (assoc given-key (right-branch set-of-records)))))

    ;; Sel
    (define (lookup keys) ; cf. lookup (3.25.n-dim-table.scm)
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
    (define (insert-record! record tree) ; cf. adjoin-set (2.65.scm)
      (cond ((null? tree)
             (make-tree record '() '()))
            ((equal-to? (key record) (key (entry tree)))
              (make-tree record
                         (left-branch tree)
                         (right-branch tree)))
             ((less-than? (key record) (key (entry tree)))
              (make-tree (entry tree)
                         (insert-record! record
                                         (left-branch tree))
                         (right-branch tree)))
             (else
              (make-tree (entry tree)
                         (left-branch tree)
                         (insert-record! record
                                         (right-branch tree))))))
    (define (add-to-table! table record)
      (set-cdr! table
                (insert-record! record
                                (cdr table))))
    (define (insert! keys value) ; cf. insert! (3.25.n-dim-table.scm)
      (let iter ((table local-table)
                 (keys keys))
        (let ((first-key (car keys))
              (rest-keys (cdr keys)))
          (let ((record (assoc first-key
                               (cdr table))))
            (if record
              (if (null? rest-keys)
                (set-cdr! record value)
                (iter record rest-keys))
              (if (null? rest-keys)
                (add-to-table! table (make-record first-key value)) ; Changed
                (let ((new-table (make-record (car keys) '())))
                  (add-to-table! table new-table) ; Changed
                  (iter new-table rest-keys))))))
        'ok))
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            ((eq? m 'get-table) local-table)
            (else (error "Unknown operation -- TABLE" m))))
    dispatch))
;; Interface
(define (get-table table)
  (table 'get-table))
(define (get table keys)
  ((table 'lookup-proc) keys))
(define (put table keys value)
  ((table 'insert-proc!) keys value))
