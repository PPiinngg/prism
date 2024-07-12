(defun line-type (str match)
  (if (< (length str) (length match))
    (return-from line-type nil))
  (subseq str 0 (length match)))
