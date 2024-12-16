;;;; 5.2
;; Use the register-machine language to describe the iterative factorial machine of exercise 5.1.

;;; Answer
(data-paths
  (registers
    ((name p)
     (buttons ((name p<-1)
               (source (constant 1)))
              ((name p<-t)
               (source (constant t)))))
    ((name c)
     (buttons ((name c<-1)
               (source (constant 1)))
              ((name c<-t)
               (source (constant t)))))
    ((name t)
     (buttons ((name t<-+)
               (source (operation +)))
              ((name t<-*)
               (source (operation *))))))
  (operations
    ((name +)
     (inputs (register c)
             (constant 1)))
    ((name *)
     (inputs (register p)
             (constant c)))))

(controller
   (p<-1)
   (c<-1)
 test-c
   (test <)
   (branch (factorial-done))
   (t<-*)
   (p<-t)
   (t<-+)
   (c<-t)
   (goto (label test-c))
 factorial-done)
