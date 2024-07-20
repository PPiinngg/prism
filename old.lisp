; (ql:quickload "cl-ppcre")

; (defun parse-link (tkn)
;   (ppcre:register-groups-bind (link)
;                               ("^=>\s*(.+?)\s+(.*)" tkn)
;     (list :link link)))

; (print (parse-link "=>https://example.com A cool website"))
; (print (parse-link "=>gopher://example.com      An even cooler gopherhole"))
; (print (parse-link "=> gemini://example.com A supremely cool Gemini capsule"))
; (print (parse-link "=>   sftp://example.com"))

; (defun parse-heading (tkn)
;   (ppcre:register-groups-bind (head text)
;                               ("^(#{1,3}) (.+)" tkn)
;     (cond ((string= head "#")   (list :h1 text))
;           ((string= head "##")  (list :h2 text))
;           ((string= head "###") (list :h3 text)))))

; (defun parse-gemtext (str)
;   (let* ((matches (ppcre:all-matches-as-strings "(?m)(?:^```.*\\n+(?:.*\\n+)+?^```\\n)|(?:^.*\\n)" str))
;          (tokens (map 'list #'(lambda (tkn) (string-right-trim '(#\return #\linefeed) tkn)) matches))n
;          (out-list '()))
;       (loop for tkn in tokens do
;         (setf out-list
;               (cons out-list
;                     (cond ((ppcre:all-matches "^=>\w*.+" tkn)   (parse-link tkn))
;                           ((ppcre:all-matches "^#{1,3} .+" tkn) (parse-heading tkn))))))
;       (reverse out-list)))

; ; link: =>\s*([^\s]+)\s*(.*)
; ; ^=>\s*[^\s]+\s*.*$
