;;; init-python-mode.el --- python mode.

;;; Commentary:

;; 

;;; Code:


;; Set up python-mode

(require-package 'jedi)

(add-hook 'python-mode-hook '(lambda ()
                              (setq jedi:setup-keys t)
                              (setq jedi:complete-on-dot t)
                              (jedi:setup)))

;;; flymake
(require-package 'flymake)
(require-package 'flymake-cursor)
(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "/usr/bin/pyflakes" (list local-file))))

  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pyflakes-init)))

(add-hook 'python-mode-hook 'flymake-mode)
(load-library "flymake-cursor")

(custom-set-faces
 '(flymake-errline ((((class color)) (:underline "red"))))
 '(flymake-warnline ((((class color)) (:underline "yellow2")))))
(setq flymake-no-changes-timeout 600)

(provide 'init-python-mode)
;;; init-python-mode ends here
