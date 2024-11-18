;;;; 3.59
;; In section 2.5.3 we saw how to implement a polynomial arithmetic system representing polynomials as lists of terms. In a similar way, we can work with *power series*, such as
;;
;; \begin{align*}
;; e^x &= 1 + x + \frac{x^2}{2} + \frac{x^3}{3 \cdot 2} + \frac{x^4}{4 \cdot 3 \cdot 2} + \cdots, \\
;; \cos x &= 1 - \frac{x^2}{2} + \frac{x^4}{4 \cdot 3 \cdot 2} - \cdots, \\
;; \sin x &= x - \frac{x^3}{3 \cdot 2} + \frac{x^5}{5 \cdot 4 \cdot 3 \cdot 2} - \cdots.
;; \end{align*}
;;
;; represented as infinite streams. We will represent the stream $a_0 + a_1 x + a_2 x^2 + a_3 x^3 + \cdots$ as the stream whose elements are the coefficients $a_0, a_1, a_2, a_3, \cdots$.
;;
;; a. The integral of the serise $a_0 + a_1 x + a_2 x^2 + a_3 x^2 + \cdots$ is the series
;;
;; $$c + a_0 x + \frac{1}{2} a_1 x^2 + \frac{1}{3} a_2 x^3 + \frac{1}{4} a_3 x^4 + \cdots$$
;;
;; where $c$ is any constant. Define a procedure `integrate-series` that takes as input a stream $a_0, a_1, a_2, \cdots$ representing a power series and returns the stream $a_0, (1/2) a_2, \cdots$ of coefficients of the non-constant terms of the integral of the series. (Since the result has no constant term, it doesn't represent a power series; when we use `integrate-series`, we will `cons` on the appropriate constant.)
;;
;; b. The function $x \mapsto e^x$ is its own derivative. This implies that $e^x% and the integral $e^x$ are the same series, except for the constant term, which is $e^0 = 1$. Accordingly, we can generate the series for $e^x$ as

(define exp-series
  (cons-stream 1 (integrate-series exp-series)))

;; Show how to generate the series for sine and cosine, starting from the facts that the derivative of sine is cosine and the derivative of cosine is the negative of sine:
;;
;; (define cosine-series
;;   (cons-stream 1 <??>))
;; (define sine-series
;;   (cons-stream 0 <??>))

;;; Answer
(load "3.streams.scm")
;; a.
(define (integrate-series s) (div-streams s integers))

;; b.
(define cosine-series
  (cons-stream 1 (scale-stream (integrate-series sine-series) -1)))
(define sine-series
  (cons-stream 0 (integrate-series cosine-series)))

;; ;; Test
;; (display-n (integrate-series ones) 0 10)
;; (display-n exp-series 0 10)
;; (display-n cosine-series 0 10)
;; (display-n sine-series 0 10)
