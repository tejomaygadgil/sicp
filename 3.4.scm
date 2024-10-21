;;;; 3.4
;; Modify the `make-account` procedure of exercise 3.3 by adding another local state variable so that, if an account is accessed more than seven consecutive times with an incorrect password, it invokes the procedure `call-the-cops`.

;;; Answer
(define (make-account balance password)
  (let ((wrong-attempts 0))
    (define (withdraw amount)
      (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
    (define (deposit amount)
      (set! balance (+ balance amount))
      balance)
    (define (wrong-password amount)
      "Incorrect password")
    (define (call-the-cops amount)
      "You have the right to remain silent")
    (define (dispatch p m)
      (if (eq? p password)
        (begin
          (set! wrong-attempts 0)
          (cond ((eq? m 'withdraw) withdraw)
                ((eq? m 'deposit) deposit)
                (else (error "Unknown request -- MAKE-ACCOUNT"
                             m))))
        (begin
          (set! wrong-attempts (+ 1 wrong-attempts))
          (if (< wrong-attempts 7)
            wrong-password
            call-the-cops))))
    dispatch))

;;; Answer
(load "0.util.scm")
(define acc (make-account 100 'password))
(test ((acc 'password 'withdraw) 40) 60)
(test ((acc 'passowrd 'withdraw) 50) "Incorrect password")
(test ((acc 'passowrd 'withdraw) 50) "Incorrect password")
(test ((acc 'passowrd 'withdraw) 50) "Incorrect password")
(test ((acc 'password 'withdraw) 50) 10) ; Reset counter
(test ((acc 'passowrd 'withdraw) 50) "Incorrect password")
(test ((acc 'passowrd 'withdraw) 50) "Incorrect password")
(test ((acc 'passowrd 'withdraw) 50) "Incorrect password")
(test ((acc 'passowrd 'withdraw) 50) "Incorrect password")
(test ((acc 'passowrd 'withdraw) 50) "Incorrect password")
(test ((acc 'passowrd 'withdraw) 50) "Incorrect password")
(test ((acc 'passowrd 'withdraw) 50) "You have the right to remain silent")
