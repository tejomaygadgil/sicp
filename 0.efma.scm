;;;; SICP 2.2.3
(define nil '())

(define (enumerate-interval low high)
  (if (> low high)
      nil
      (cons low (enumerate-interval (+ low 1) high))))
(define (enumerate-tree tree)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (list tree))
        (else (append (enumerate-tree (car tree))
                      (enumerate-tree (cdr tree))))))

(define (filter predicate sequence)
  (cond ((null? sequence)
         nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate
                       (cdr sequence))))
        (else (filter predicate
                      (cdr sequence)))))

;; (define (map p sequence)
;;   (accumulate (lambda (x y) (cons (p x) y))
;;               nil
;;               sequence))

;; fold-right starts from the end and calculates backwards --
;; This is due to applicative-order by which the inner-most expression is evaluted first
(define (accumulate op initial sequence) ; fold-right: (op s_1 ... (op s_2 (op s_n initial)) ... )
  (if (null? sequence) initial
      (op (car sequence) ; next: previous element
          (accumulate op initial (cdr sequence))))) ; prev: next element


(define (flatmap proc seq)
  (accumulate append
              nil
              (map proc seq)))

(define (remove item sequence)
  (filter (lambda (x) (not (eq? x item)))
          sequence))

(define (permutations s)
  (if (null? s)
      (list nil)
      (flatmap (lambda (x)
                 (map (lambda (p) (cons x p))
                      (permutations (remove x s))))
               s)))

(define (combinations s r)
  (if (null? s) s
    (if (= r 1) (map (lambda (x) (cons x nil)) s) ; Hack
      (append
        (map (lambda (x) (cons (car s) x))
           (combinations (cdr s) (- r 1)))
        (combinations (cdr s) r)))))

(define (product r s)
    (if (null? s) r
      (map (lambda (x) (product (cons x r)  (cdr s)))
           (car s))))

(define (product lists) ; https://stackoverflow.com/a/20591545
  (accumulate (lambda (new acc)
                (append-map (lambda (v)
                              (map (lambda (l)
                                     (cons v l))
                                   acc))
                            new))
              '(())
              lists))

(define (shuffle list) ; Fisher-Yates shuffle (https://en.wikipedia.org/wiki/Fisher–Yates_shuffle)
  (define (iter shuffled original)
    (if (null? original) shuffled
      (let ((i (random (length original))))
        (iter (cons (list-ref original i) shuffled)
              (append (take original i)
                      (cdr (drop original i)))))))
  (iter '() list))
