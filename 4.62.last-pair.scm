(assert! (rule (last-pair (?x) (?x)))) ; Base case
(assert! (rule (last-pair (?u . ?v) (?x))
         (last-pair ?v (?x)))) ; Recurse
