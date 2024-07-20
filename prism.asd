(ql:quickload "usocket")
(ql:quickload "str")
; (ql:quickload "cl-ppcre")
; (ql:quickload "bt-semaphore")

(asdf:defsystem #:prism
  :description "Polyglot small web framework"
  :version "0.0.1"
  :author "Zora Harrison"
  :depends-on (#:str #:usocket)
  :pathname "src/"
  :components ((:file "packages")
               (:file "config" :depends-on ("packages"))
               (:file "finger" :depends-on ("packages" "config"))))
