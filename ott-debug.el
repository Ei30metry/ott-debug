;;; ott-debug.el --- Prettify ott's multiple parse errors in tree format -*- lexical-binding: t; -*-
;;; Code:
(require 'comint)

(defconst +space+
  "    ")
(defconst +pipe+
  " │  ")
(defconst +tee+
  " ├─ ")
(defconst +lower-knee+
  " ╰─ ")

(defun format-tree-segments (node)
  (unless node
    (cl-return-from format-tree-segments nil))
  (cl-flet ((prefix-node-strings (child-node &key
                                             (root-connector  +tee+)
                                             (lower-connector +pipe+))
              (cl-multiple-value-bind (r l)
                  (format-tree-segments child-node)
                (nconc
                 (list (cl-concatenate 'string root-connector r))
                 (mapcar
                  (lambda (str) (cl-concatenate 'string lower-connector str))
                  l)))))
    (let ((children (rest node)))
      (values
       (let ((root-name (funcall #'symbol-name (car node))))
         (if (= 1 (length root-name))
             (cl-concatenate 'string " " root-name)
             root-name))
       (when children
         (cl-loop
               for (head . tail) on children
               while tail
               nconc (prefix-node-strings head)
               into strlist
               finally (cl-return
                          (nconc
                           strlist
                           (prefix-node-strings head
                                                :root-connector  +lower-knee+
                                                :lower-connector +space+)))))))))
(defun format-tree (tree)
  (cl-multiple-value-bind (r l)
      (format-tree-segments tree)
    (cl-loop for i in (nconc (list r) l) do (insert (format "%s\n" i)))))


(provide 'ott-debug)
;;; ott-debug.el ends here
