(define primitive-procedures
  (list (list 'car car)
        (list 'cdr cdr)
        (list 'caar caar)
        (list 'cadr cadr)
        (list 'cdar cdar)
        (list 'cddr cddr)
        (list 'caaar caaar)
        (list 'caadr caadr)
        (list 'cadar cadar)
        (list 'caddr caddr)
        (list 'cdaar cdaar)
        (list 'cdadr cdadr)
        (list 'cddar cddar)
        (list 'cdddr cdddr)
        (list 'caaaar caaaar)
        (list 'caaadr caaadr)
        (list 'caadar caadar)
        (list 'caaddr caaddr)
        (list 'cadaar cadaar)
        (list 'cadadr cadadr)
        (list 'caddar caddar)
        (list 'cadddr cadddr)
        (list 'cdaaar cdaaar)
        (list 'cdaadr cdaadr)
        (list 'cdadar cdadar)
        (list 'cdaddr cdaddr)
        (list 'cddaar cddaar)
        (list 'cddadr cddadr)
        (list 'cdddar cdddar)
        (list 'cddddr cddddr)
        (list 'member member)
        (list 'set-car! set-car!)
        (list 'set-cdr! set-cdr!)
        (list 'apropos apropos)
        (list 'pp pp)
        (list 'length length)
        (list 'cons cons)
        (list 'list list)
        (list 'assoc assoc)
        (list 'null? null?)
        (list 'number? number?)
        (list 'string? string?)
        (list 'symbol? symbol?)
        (list 'pair? pair?)
        (list 'list? list?)
        (list '+ +)
        (list '- -)
        (list '* *)
        (list '/ /)
        (list '= =)
        (list '< <)
        (list '> >)
        (list 'abs abs)
        (list 'remainder remainder)
        (list 'modulo modulo)
        (list 'not not)
        (list 'eq? eq?)
        (list 'equal? equal?)
        ;; (list 'apply apply)
        (list 'memq memq)
        (list 'make-hash-table make-hash-table)
        (list 'hash-table/put! hash-table/put!)
        (list 'hash-table/get hash-table/get)
        (list 'display display)
        (list 'newline newline)
        (list 'read read)
        (list 'read-file read-file)
        (list 'error error)
        (list 'bkpt bkpt)
        (list 'debug debug)
        (list 'exit exit)
        ))
(define (primitive-procedure-names)
  (map car primitive-procedures))
(define (primitive-procedure-objects)
  (map (lambda (proc)
         (list 'primitive
               (if (primitive-procedure? (cadr proc))
                 (cadadr proc)
                 (cadr proc))))
       primitive-procedures))