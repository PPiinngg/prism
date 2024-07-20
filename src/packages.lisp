(defpackage #:prism-config
  (:use #:common-lisp)
  (:export #:*listen-ip*))

(defpackage #:prism-finger
  (:use #:common-lisp)
  (:export #:start-finger-server
           #:stop-finger-server))