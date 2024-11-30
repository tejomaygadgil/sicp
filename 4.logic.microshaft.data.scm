(define microshaft-data-base
  '(;; Assertions
    (job (Bitdiddle Ben) (computer wizard))
    (job (Hacker Alyssa P) (computer programmer))
    (job (Fect Cy D) (computer programmer))
    (job (Tweakit Lem E) (computer technician))
    (job (Reasoner Louis) (computer programmer trainee))
    (job (Warbucks Oliver) (administration big wheel))
    (job (Scrooge Eben) (accounting chief accountant))
    (job (Cratchet Robert) (accounting scrivener))
    (job (Aull DeWitt) (administration secretary))
    (address (Bitdiddle Ben) (Slumerville (Ridge Road) 10))
    (address (Hacker Alyssa P) (Cambridge (Mass Ave) 78))
    (address (Fect Cy D) (Cambridge (Ames Street) 3))
    (address (Tweakit Lem E) (Boston (Bay State Road) 22))
    (address (Reasoner Louis) (Slumerville (Pine Tree Road) 80))
    (address (Warbucks Oliver) (Swellesley (Top Heap Road)))
    (address (Scrooge Eben) (Weston (Shady Lane) 10))
    (address (Cratchet Robert) (Allston (N Harvard Street) 16))
    (address (Aull DeWitt) (Slumerville (Onion Square) 5))
    (supervisor (Bitdiddle Ben) (Warbucks Oliver))
    (supervisor (Hacker Alyssa P) (Bitdiddle Ben))
    (supervisor (Fect Cy D) (Bitdiddle Ben))
    (supervisor (Tweakit Lem E) (Bitdiddle Ben))
    (supervisor (Reasoner Louis) (Hacker Alyssa P))
    (supervisor (Scrooge Eben) (Warbucks Oliver))
    (supervisor (Cratchet Robert) (Scrooge Eben))
    (supervisor (Aull DeWitt) (Warbucks Oliver))
    (salary (Bitdiddle Ben) 60000)
    (salary (Hacker Alyssa P) 40000)
    (salary (Fect Cy D) 35000)
    (salary (Tweakit Lem E) 25000)
    (salary (Reasoner Louis) 30000)
    (salary (Warbucks Oliver) 150000)
    (salary (Scrooge Eben) 75000)
    (salary (Cratchet Robert) 18000)
    (salary (Aull DeWitt) 25000)
    (can-do-job (computer wizard) (computer programmer))
    (can-do-job (computer wizard) (computer technician))
    (can-do-job (computer programmer) (computer programmer trainee))
    (can-do-job (administration secretary) (administration big wheel))
    ;; Rules
    (rule (same ?x ?x))
    (rule (lives-near ?person-1 ?person-2)
          (and (address ?person-1 (?town . ?rest-1))
               (address ?person-2 (?town . ?rest-2))
               (not (same ?person-1 ?person-2))))
    (rule (wheel ?person)
          (and (supervisor ?middle-manager ?person)
               (supervisor ?x ?middle-manager)))
    (rule (outranked-by ?staff-person ?boss)
          (or (supervisor ?staff-person ?boss)
              (and (supervisor ?staff-person ?middle-manager)
                   (outranked-by ?middle-manager ?boss))))))
