;;; init-undo-tree.el --- Undo tree

;;; Commentary:
;;

;;; Code:

;; undo-tree
(require-package 'undo-tree)
(global-undo-tree-mode)
(diminish 'undo-tree-mode)


(provide 'init-undo-tree)
;;; init-undo-tree ends here
