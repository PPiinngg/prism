(defun line-type (str match)
  (if (< (length str) (length match))
    nil
    (string= (subseq str 0 (length match))
             match)))
