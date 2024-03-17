(print "hello world")


(defn myfunc [x]
  (+ x 1))

(myfunc 2)
(file/read (file/open "testfile.txt" :r) :all)
