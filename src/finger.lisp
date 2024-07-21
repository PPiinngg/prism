;;;; Basic finger server using static files from
;;;; the "finger" directory at this repo's root

;;;; [WARN] ONLY WORKS WITH FLAT FINGER FOLDER
;;;; WE DISALLOW SLASHES TO AVOID PATH INJECTION

(in-package #:prism-finger)

(defvar *port* 79)
(defvar *listener* nil)
(defvar *server-thread* nil)

(defun sanitise-path (path)
  (if (string= "" path)
    (return-from sanitise-path "finger/root"))
  (if (or (find #\/ path)
          (find #\\ path))
      (return-from sanitise-path "finger/404"))
  (if (not (uiop:file-exists-p path))
    (return-from sanitise-path "finger/404")))

(defun handle-finger-request (socket)
  (let ((char-stream (usocket:socket-stream socket)))
    (unwind-protect
      (let* ((query (string-right-trim '(#\return) (read-line char-stream)))
             (path (sanitise-path query)))
        (format char-stream (str:from-file path))
        (force-output char-stream)))
    (usocket:socket-close socket)))

(defun finger-server ()
  (loop do
    (let ((socket (usocket:socket-accept *listener*
                                         :element-type 'character)))
    	(bt:make-thread (lambda () (handler-case
                                   (bt:with-timeout (5) ;5 second limit
                                     (handle-finger-request socket))
                                   (bt:timeout ()
                                     (print "[ERROR] finger connection timed out")
                                     (usocket:socket-close socket))))
                      :name "finger connection"))))

(defun start-finger-server ()
  (setf *listener*
        (usocket:socket-listen prism-config:*listen-ip* *port*))
  (setf *server-thread*
        (bt:make-thread #'finger-server :name "finger-server-thread")))

(defun stop-finger-server ()
  (bt:destroy-thread *server-thread*)
  (usocket:socket-close *listener*)
  (setf *listener* nil))
