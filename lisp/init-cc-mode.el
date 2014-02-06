;;; init-cc-mode.el --- C/C++ indentation style.
;;
;;; Commentary:
;;
;;; Code:

(defun my-c-mode-hook ()
  ;; @see http://stackoverflow.com/questions/3509919/ \
  ;; emacs-c-opening-corresponding-header-file
  (local-set-key "\M-f" 'c-forward-into-nomenclature)
  (local-set-key "\M-b" 'c-backward-into-nomenclature)
  
  (setq cc-search-directories '("." "/usr/include" "/usr/local/include/*" "../*/include"))

  ;; BSD-ish indentation style.
  (setq tab-width 4)
  (setq c-tab-always-indent t)
  (setq c-indent-level 4)
  (setq c-basic-offset 4)
  (setq c-brace-offset -4)
  (setq c-argdecl-indent 0)
  (setq c-continued-statement-offset 4)
  (setq c-style-variables-are-local-p nil)

  ;;if (0)          becomes        if (0)
  ;;    {                          {
  ;;       ;                           ;
  ;;    }                          }
  (c-set-offset 'substatement-open 0)

  ;syntax-highlight aggressively
  ;(setq font-lock-support-mode 'lazy-lock-mode)
  (setq lazy-lock-defer-contextually t)
  (setq lazy-lock-defer-time 0)

  ;make DEL take all previous whitespace with it
  (c-toggle-hungry-state 1)

  ;make open-braces after a case: statement indent to 0 (default was '+)
  (c-set-offset 'statement-case-open 0)

  ;make a #define be left-aligned
  (setq c-electric-pound-behavior (quote (alignleft)))

  ;do not impose restriction that all lines not top-level be indented at least
  ;1 (was imposed by gnu style by default)
  (setq c-label-minimum-indentation 0)
  )

;; donot use c-mode-common-hook or cc-mode-hook because many major-modes use this hook
(add-hook 'c-mode-hook 'my-c-mode-hook)
(add-hook 'c++-mode-hook 'my-c-mode-hook)

(provide 'init-cc-mode)
;;; init-cc-mode.el ends here
