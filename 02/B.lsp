(require "asdf")

(defvar h 0)
(defvar d 0)
(defvar a 0)
(defvar vari 0)

(defvar *data*
  (mapcar
    (lambda(x) (uiop:split-string x))
    (uiop:read-file-lines "input.txt")))


(dolist (op *data*)
    (cond ((string= (first op) "forward")
        (setq h (+ h (parse-integer (second op))))
        (setq d (+ d (* a (parse-integer (second op)))))))
    (if (string= (first op) "down") (setq a (+ a (parse-integer (second op)))))
    (if (string= (first op) "up") (setq a (- a (parse-integer (second op))))))

(print (* h d))
