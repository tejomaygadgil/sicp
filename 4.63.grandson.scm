(assert!
  (rule (son ?father ?son)
        (and (wife ?father ?wife)
             (son ?wife ?son))))
(assert!
  (rule (grandson ?grandfather ?grandson)
        (and (son ?grandfather ?father)
             (son ?father ?grandson))))
