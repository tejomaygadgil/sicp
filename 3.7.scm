;;;; 3.7.scm
;; Consider the bank account objects created by `make-account`, with the password modification described in exercise 3.3. Suppose that our banking system requires the ability to make joint accounts. Define a procedure `make-joint` that accomplishes this. `Make-joint` should take three arguments. The first is a password-protected account. The second argument must match the password with which the account was defined in order for the `make-joint` operation to proceed. The third argument is a new password. Make-joint is to create an additional access to the original account using the new password. For example, if `peter-acc` is a bank account with password `open-sesame`, then
;;
;; (define paul-acc
;;   (make-joint peter-acc 'open-sesame 'rosebud))
;;
;; will allow one to make transactions on `peter-acc` using the name `paul-acc` and the password `rosebud.` You may wish to modify your solution to exercise 3.3 to accommodate this new feature.

;;; Answer
(define (make-joint account password new-password)
  ((account password 'withdraw) 0) ; Test account access
  (define (dispatch p m)
    (if (eq? p new-password)
      (account password m)
      (error "Incorrect joint password -- MAKE-JOINT")))
  dispatch)

;; Test
(load "0.util.scm")
(load "3.3.make-account.scm")
(define a1 (make-account 100 'open-sesame))
(test ((a1 'open-sesame 'withdraw) 40) 60)
(define a2 (make-joint a1 'open-sesame 'rosebud))
(test ((a1 'open-sesame 'withdraw) 20) 40)
(test ((a2 'rosebud 'withdraw) 20) 20)
