;;;; 3.3
;; Modify the `make-account` procedure so that it creates password-protected accounts. That is, `make-account` should take a symbol as an additional argument, as in
;;
;; (define acc (make-account 100 'secret-password))
;;
;; The resulting account object should process a request only if it is accompanied by the password with which the account was created, and should otherwise return a complaint:
;;
;; ((acc 'secret-password 'withdraw) 40)
;; 60
;;
;; ((acc 'some-other-password 'deposit) 50)
;; "Incorrect password"

;; Test
(load "0.util.scm")
(load "3.3.make-account.scm")
(define acc (make-account 100 'password))
(test ((acc 'password 'withdraw) 40) 60)
(test ((acc 'password 'withdraw) 40) 20)
;; ((acc 'passowrd 'withdraw) 50) ; Failse
