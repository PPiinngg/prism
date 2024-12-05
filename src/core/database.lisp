(in-package #:prism-core)

(defvar *capsule-db* (make-hash-table :test 'equal
                                      :size 256
                                      :rehash-size 256))

(defun register-page (slug content)
  "CONTENT must either be a list of gemtext tokens or a function object that takes no arguments."
  (setf (gethash slug *capsule-db*) content))

(defun get-page (slug)
  (let ((page (gethash slug *capsule-db*)))
    (if (equal (type-of page)
               'compiled-function)
        (funcall page)
        page)))
