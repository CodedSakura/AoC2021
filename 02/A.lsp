(require "asdf")

(defvar x 0)
(defvar y 0)

(defvar *data*
  (mapcar
    (lambda(x) (uiop:split-string x))
    (uiop:read-file-lines "input.txt")))


(dolist (op *data*)
    (if (string= (first op) "forward") (setq x (+ x (parse-integer (second op)))))
    (if (string= (first op) "down") (setq y (+ y (parse-integer (second op)))))
    (if (string= (first op) "up") (setq y (- y (parse-integer (second op))))))

(print (* x y))
