;;; [TODO]: "require-trailing-whitespace" param
(defun line-type (str match)
  (if (< (length str) (length match))
    nil
    (string= (subseq str 0 (length match))
             match)))

(let ((line "AAAATEST"))
  (cond ((line-type line "=>"))
        (t)))
