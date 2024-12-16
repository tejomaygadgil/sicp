;; Util
(load "0.table.scm")
;; Obj
(load "5.register-machine.machine-monitor.scm")
(load "5.register-machine.register.scm")
(load "5.register-machine.stack-monitor.scm")
;; Interface
(load "5.register-machine.tagged-list.scm")
(load "5.register-machine.label.scm")
(load "5.register-machine.instruction.scm")
(load "5.register-machine.exp.primitive.scm")
(load "5.register-machine.exp.operation.scm")
;; Core
(load "5.register-machine.assembler.scm")
(load "5.register-machine.execution.scm")
;; Install
(load "5.register-machine.execution.assign.scm")
(load "5.register-machine.execution.test.scm")
(load "5.register-machine.execution.branch.scm")
(load "5.register-machine.execution.goto.scm")
(load "5.register-machine.execution.save-restore.scm")
(load "5.register-machine.execution.perform.scm")
(define *op-table* (make-hash-table))
(install-assign-package)
(install-test-package)
(install-branch-package)
(install-goto-package)
(install-save-restore-package)
(install-perform-package)
