(ql:quickload "bordeaux-threads")
(ql:quickload "usocket")
(ql:quickload "str")

(asdf:defsystem #:prism
  :description "Polyglot small web framework"
  :version "0.0.1"
  :author "Zora Harrison"
  :depends-on (#:bordeaux-threads #:usocket #:str)
  :pathname "src/"
  :components ((:file "packages")
               (:file "config" :depends-on ("packages"))
               (:file "finger" :depends-on ("packages" "config"))))
