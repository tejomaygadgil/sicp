(load "0.table.scm")
(load "2.tagged-data.scm")

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args))) ; Data abstraction (type-tag)
    (let ((proc (get op type-tags))) ; Data abstraction (get)
      (if proc
          (apply proc (map contents args)) ; Data abstraction (contents)
          (error
            "No method for these types -- APPLY-GENERIC"
            (list op type-tags))))))
