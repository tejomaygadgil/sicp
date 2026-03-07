(define (install-grandson)
  (for-each mc-eval
            (list '(assert!
                    (rule (son ?father ?son)
                          (and (wife ?father ?wife)
                               (son ?wife ?son))))
                  '(assert!
                    (rule (grandson ?grandfather ?grandson)
                          (and (son ?grandfather ?father)
                               (son ?father ?grandson)))))))
