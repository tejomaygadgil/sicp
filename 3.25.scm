;;;; 2.25
;; Generalizing one- and two-dimensional tables, show how to implement a table in which values are stored under an arbitrary number of keys and different values may be stored under different numbers of keys. The `lookup` and `insert!` procedures should take as input a list of keys used to access the table.

;; Test
(load "0.util.scm")
(load "3.25.n-dim-table.scm")
(define (test-put table keys val)
  (put table keys val)
  (test (get table keys) val))
(define things (make-table))
(test (get things '(vegetable)) false)
(test-put things '(vegetable) 'celery)
(test-put things '(fruit yellow) 'banana)
(test-put things '(fruit orange) 'mango)
(test-put things '(fruit green) 'pear)
(test-put things '(fruit) 'apple) ; Overwrite
(test-put things '(furniture working wooden) 'chair)
(test-put things '(furniture relaxing felt) 'couch)
