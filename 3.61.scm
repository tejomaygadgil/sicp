;;;; 3.61
;; Let $S$ be a power series (exercise 3.59) whose constant term is 1. Suppose we want to find the power series $1/S$, that is, the series $X$ such that $S · X = 1$. Write $S = 1 + S_R$ where $S_R$ is the part of $S$ after the constant term. Then, we can solve for $X$ as follows:
;;
;; $$
;; \begin{align*}
;; S \cdot X &= 1 \\
;; (1 + S_R) \cdot X &= 1 \\
;; X + S_R \cdot X &= 1 \\
;; X &= 1 - S_R \cdot X
;; \end{align*}
;; $$
;;
;; In other words, $X$ is the power series whose constant term is 1 and whose higher-order terms are given by the negative of $S_R$ times $X$. Use this idea to write a procedure `invert-unit-series` that computes $1/S$ for a power series $S$ with constant term 1. You will need to use `mul-series` from exercise 3.60.

(load "3.60.scm")
;; `invert-unit-series` works works because we have
;; defined $X$ in terms of a delayed version of itself.
;; Using the facts that its constant is 1 and and its
;; multiplicative relationship to the coefficients of
;; $S$, we can easily describe its value in the stream
;; language we have built up thus far:
(define (invert-unit-series s)
  (define inverted-s ; Memoize, cf. 3.55.scm
    (cons-stream 1
                 (scale-stream (mul-series (stream-cdr s)
                                           inverted-s)
                               -1)))
  inverted-s)

;; Test
(load "0.util.scm")
(define inverted-ones (invert-unit-series ones))
(map (lambda (x)
       (test (stream-ref inverted-ones x)
             (cond ((= x 0) 1)
                   ((= x 1) -1)
                   (else 0))))
     (iota 10))
