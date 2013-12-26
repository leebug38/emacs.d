;;; init-auto-complete.el --- auto complete mode

;;; Commentary:

;;; Code:

(require-package 'auto-complete)
(require 'auto-complete-config)

(ac-config-default)
(global-auto-complete-mode t)
;(setq-default ac-expand-on-auto-complete nil)
(setq-default ac-auto-start 1)
(setq-default ac-dwim t)
;(setq ac-quick-help_delay 0.5)

;;----------------------------------------------------------------------------
;; Use Emacs' built-in TAB completion hooks to trigger AC (Emacs >= 23.2)
;;----------------------------------------------------------------------------
(setq tab-always-indent 'complete)  ;; use 't when auto-complete is disabled
(add-to-list 'completion-styles 'initials t)

;; (set-default 'ac-sources
;;              '(ac-source-imenu
;;                ac-source-dictionary
;;                ac-source-words-in-buffer
;;                ac-source-words-in-same-mode-buffers
;;                ac-source-words-in-all-buffer))

;; (dolist (mode '(magit-log-edit-mode
;;                 log-edit-mode org-mode text-mode haml-mode
;;                 git-commit-mode python-mode
;;                 sass-mode yaml-mode csv-mode espresso-mode haskell-mode
;;                 html-mode nxml-mode sh-mode smarty-mode clojure-mode
;;                 lisp-mode textile-mode markdown-mode tuareg-mode
;;                 js3-mode css-mode less-css-mode sql-mode
;;                 sql-interactive-mode
;;                 c-mode c++-mode
;;                 inferior-emacs-lisp-mode))
;;   (add-to-list 'ac-modes mode))

;;; Auto pair mode.
(require-package 'autopair)
(autopair-global-mode)

(provide 'init-auto-complete)
;;; init-auto-complete ends here
