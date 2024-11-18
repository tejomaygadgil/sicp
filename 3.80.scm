;;;; 3.80
;; A *series RLC circuit* consists of a resistor, a capacitor, and an inductor connected in series, as shown in figure 3.36. If $R$, $L$, and $C$ are the resistance, inductance, and capacitance, then the relations between voltage ($v$) and current ($i$) for the three components are described by the equations
;;
;; $$
;; \begin{align*}
;; v_R & = i_R R \\
;; v_L & = L \frac{d i_L}{dt} \\
;; i_C & = C \frac{d v_C}{dt}
;; \end{align*}
;; $$
;;
;; and the circuit connections dictate the relations
;;
;; $$
;; \begin{align*}
;; i_R & = i_L = -i_C \\
;; v_C & = v_L + v_R
;; \end{align*}
;; $$
;;
;; Combining these equations shows that the state of the circuit (summarized by $v_C$, the voltage across the capacitor, and $i_L$, the current in the inductor) is described by the pair of differential equations
;;
;; $$
;; \begin{align*}
;; \frac{d v_C}{dt} & = -\frac{i_L}{C} \\
;; \frac{d i_L|}dt| & = \frac{1}{L} v_C - \frac{R}{L} i_L
;; \end{align*}
;; $$
;;
;; The signal-flow diagram representing this system of differential equations is shown in figure 3.37.
;;
;; Write a procedure `RLC` that takes as arguments the parameters $R$, $L$, and $C$ of the circuit and the time increment $dt$. In a manner similar to that of the `RC` procedure of exercise 3.73, `RLC` should produce a procedure that takes the initial values of the state variables, $v_{C_0}$ and $i_{L_0}$, and produces a pair (using `cons`) of the streams of states $v_C$ and $i_L$. Using `RLC`, generate the pair of streams that models the behavior of a series RLC circuit with $R$ = 1 ohm, $C$ = 0.2 farad, $L$ = 1 henry, $dt$ = 0.1 second, and initial values $i_{L_0}$ = 0 amps and $v_{C_0}$ = 10 volts.

;;; Answer
(load "3.streams.scm")
(load "3.stream.solve.scm")
(define (RLC R L C dt)
  (lambda (vc0 iL0)
    (define vC (integral (delay dvC) vc0 dt))
    (define iL (integral (delay diL) iL0 dt))
    (define dvC (scale-stream iL (/ -1. C)))
    (define diL (add-streams (scale-stream vC (/ 1. L))
                             (scale-stream iL (* -1. (/ R L)))))
    (stream-map cons vC iL)))

;; Test
(display-n ((RLC 1 0.2 1 0.1) 10 0) 0 20)
