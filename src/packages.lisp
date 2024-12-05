(defpackage #:prism-core
  (:use #:common-lisp)
  (:export #:register-static-page
           #:register-dynamic-page
           #:get-page))

(defpackage #:prism-config
  (:use #:common-lisp)
  (:export #:*listen-ip*))

(defpackage #:prism-finger
  (:use #:common-lisp)
  (:export #:start-finger-server
           #:stop-finger-server))

(defpackage #:prism-gemini
  (:use #:common-lisp)
  (:export #:start-gemini-server
           #:stop-gemini-server))
