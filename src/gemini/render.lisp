(in-package #:prism-gemini)

(defun render-token-concat (tkn)
  (let ((nl (string #\newline)))
    (cond ((eq (car tkn) :empty) nl)
          ((eq (car tkn) :text) (cadr tkn))
          ((eq (car tkn) :link) (format nil "=>~{ ~a~}" (cdr tkn)))
          ((eq (car tkn) :list) (format nil "* ~a" (cadr tkn)))
          ((eq (car tkn) :quote) (format nil ">~a" (cadr tkn)))
          ((eq (car tkn) :preform) (format nil "```~{~a~%~}```" (cdr tkn)))
          ((eq (car tkn) :head)
            (format nil "~[#~;##~;###~] ~a" (1- (cadr tkn)) (caddr tkn))))))

(defun render (tokens)
  (str:join #\newline
            (map 'list #'render-token tokens)))
