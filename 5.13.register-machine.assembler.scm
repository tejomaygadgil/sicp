(define (assemble controller-text machine)
  (let ((flist (machine 'flist))
        (alist (machine 'alist)))
    (define (extract-labels text receive)
      (if (null? text)
          (receive '() '())
          (extract-labels
           (cdr text)
           (lambda (insts labels) ; Continuation
             (let ((next-inst (car text)))
               (data-path-parse flist alist next-inst) ; Parse data path
               (if (symbol? next-inst)
                   (receive insts
                       (cons (make-label-entry next-inst
                                               insts)
                             labels))
                   (receive (cons (make-instruction next-inst)
                                  insts)
                       labels)))))))
    (define (update-registers!)
      (for-each (lambda (register-name)
                  ((machine 'allocate-register) register-name))
                (cdr (assoc 'reg (flist 'get)))))
    (define (update-insts! insts labels machine)
      (let ((pc (get-register machine 'pc))
            (flag (get-register machine 'flag))
            (stack (machine 'stack))
            (ops (machine 'operations)))
        (for-each
         (lambda (inst)
           (set-instruction-execution-proc!
            inst
            (make-execution-procedure ; Dispatch on type
             (instruction-text inst) labels machine
             pc flag stack ops)))
         insts)))
    (extract-labels controller-text
                    (lambda (insts labels)
                      (update-registers!) ; Update registers
                      (update-insts! insts labels machine)
                      insts))))
