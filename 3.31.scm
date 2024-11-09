(load "3.circuit.scm")
(load "3.31.wire.scm")

(define input-1 (make-wire))
(define input-2 (make-wire))
(define sum (make-wire))
(define carry (make-wire))
(probe 'input-1 input-1)
(probe 'input-2 input-2)
(probe 'sum sum)
(probe 'carry carry)

(half-adder input-1 input-2 sum carry)
(set-signal! input-1 1)
(propagate) ;; Nothing happens!
(newline)
