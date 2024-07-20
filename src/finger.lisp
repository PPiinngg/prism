;;;; Basic finger server serving static files from
;;;; the "finger" directory at this repo's root

(in-package #:prism-finger)

(defvar *port* 79)
(defvar *listener* nil)

(defun handle-finger-request (socket)
  (let ((char-stream (usocket:socket-stream socket)))
    (unwind-protect
      (let* ((selector (string-right-trim '(#\return)
                                          (read-line char-stream)))
             (unchecked-path (if (string= "" selector)
                                 "finger/index"
                                 (str:concat "finger/" selector)))
             (path (if (uiop:file-exists-p unchecked-path)
                       unchecked-path
                       "finger/404")))
         (format char-stream (str:from-file path))
         (force-output char-stream)))
    (usocket:socket-close socket)))

(defun finger-server ()
  (loop do
    (let ((socket (usocket:socket-accept *listener*
                                         :element-type 'character)))
    	(handle-finger-request socket)))) ;[TODO] Spin up request thread

(defun start-finger-server ()
  (setf *listener* (usocket:socket-listen prism-config:*listen-ip* *port*))
  (finger-server)) ;[TODO] Spin up server thread

(defun stop-finger-server ()
  ;[TODO] Kill server thread
  (usocket:socket-close *listener*)
  (setf *listener* nil))
