;;; init.el --- yc's emacs init file.

;;; Commentary:
;;
;; Author: Yue Chao <y.lechao@gmail.com>
;; Date: 9 December 2013
;;
;; 本配置对以下项目做了一些定制：
;; * C/C++
;; * Python
;; * lisp
;; * javascript

;;; Code:

;;----------------------------------------------------------------
;; 设置自己的lisp载入路径.
;;----------------------------------------------------------------

(add-to-list 'load-path (concat user-emacs-directory "lisp"))

;;----------------------------------------------------------------
;; 基础配置，这些配置会被后面的配置模块使用，所以要最先导入。
;;----------------------------------------------------------------

;; 我在mac系统上使用Emacs 24.
(defconst *is-a-mac* (eq system-type 'darwin))

;; 定义after-load, add-auto-mode等。
(require 'init-utils)

;; 设置载入路径。
(require 'init-site-lisp)

;; 设置package软件源。
(require 'init-elpa)

;;----------------------------------------------------------------
;; 下面这些扩展让emacs更容易使用。
;;----------------------------------------------------------------

(require-package 'diminish)
(require-package 'scratch)

;; 记住以往输入过的历史命令。
(require-package 'mwe-log-commands)


;;----------------------------------------------------------------
;; 导入各子模块的配置。
;;----------------------------------------------------------------

(require 'init-editing-utils)
(require 'init-themes)
(require 'init-dired)
(require 'init-isearch)
(require 'init-uniquify)
(require 'init-ibuffer)
(require 'init-flycheck)
(require 'init-ido)
(require 'init-undo-tree)
(require 'init-hippie-expand)
(require 'init-auto-complete)
(require 'init-mmm)
(require 'init-markdown)
(require 'init-javascript)
(require 'init-org)
(require 'init-python-mode)
(require 'init-cc-mode)
;(require 'init-go-mode)
(require 'init-sql)
(require 'init-paredit)
;(require 'init-lisp)
;(require 'init-common-lisp)
(when *is-a-mac*
  (require-package 'osx-location))
(require-package 'regex-tool)


;;----------------------------------------------------------------
;; Variables configured via the interactive 'customize' interface
;;----------------------------------------------------------------
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))


;;----------------------------------------------------------------
;; Allow users to provide an optional "init-local" containing personal settings
;;----------------------------------------------------------------
(require 'init-local nil t)


;;----------------------------------------------------------------
;; Locales (setting them earlier in this file doesn't work in X)
;;----------------------------------------------------------------
(require 'init-locales)


(provide 'init)

;;; Local Variables:
;;; coding: utf-8
;;; no-byte-compile: t

;;; init ends here
