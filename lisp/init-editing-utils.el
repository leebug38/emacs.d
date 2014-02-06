;;; init-editing-utils.el --- Basic edit preferences

;;; Commentary:

;;; Code:

(when *is-a-mac*
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier 'none))


;;(require-package 'unfill)
(require-package 'whole-line-or-region)

(when (fboundp 'electric-pair-mode)
  (setq-default electric-pair-mode 1))

;;-----------------------------------------------------
;; Some basic preferences
;;-----------------------------------------------------

(when *is-a-mac*
  (setq-default locate-command "mdfind"))

(fset 'yes-or-no-p 'y-or-n-p)

;; 默认使用UTF-8编码。
(setq current-language-environment "UTF-8")
(setq default-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; 默认字体
(when *is-a-mac*
  (set-frame-font "Monaco-16"))
(set-frame-font "Monaco-12")

;; 缺省模式改为text模式。
(setq default-major-mode 'text-mode)

;; 允许与其它程序之间copy/paste
(setq x-select-enable-clipboard t)

;; 显示行号
(global-linum-mode 1)

;; 设置行最大长度为79
(setq default-fill-column 79)

;; 设置kill-ring的长度。
(setq kill-ring-max 200)

;; 滚动页面而不是翻页。
;; 当向下移动光标至倒数第3行时，自动向上滚动页面，而不是翻页。
;; (向上移动有同样的处理方式）
(setq scroll-margin 3
      scroll-conservatively 10000)

;; 设置tab的宽度为4
(setq default-tab-width 4)
;; 使用空格替换tab
(setq-default indent-tabs-mode nil)

;; auto revert mode
;; 当buffer中的文件被修改时，emacs能自动从新加载该文件。
;; (global-auto-revert-mode)
;; (setq global-auto-revert-non-file-buffers t
;;       auto-revert-verbose nil)

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)

;;------------------------------------------------------------------
;; here is my settings copying from others
;;------------------------------------------------------------------
;; 标题栏显示文件路径
(setq frame-title-format 
 '("%S" (buffer-file-name "%f"  
         (dired-directory dired-directory "%b")))) 
;;------------------------------------------------------------------
;; 启动emacs时窗口最大化  
;(defun my-maximized () 
; (interactive)  
; (x-send-client-message  
;  nil 0 nil "_NET_WM_STATE" 32  
;  '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))  
; (x-send-client-message  
;  nil 0 nil "_NET_WM_STATE" 32  
;  '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0)))  
;(my-maximized)  
;;-------------------------------------------------------------------
;; 设置C-a移动更为智能
;; { smarter navigation to the beginning of a line
;; http://emacsredux.com/blog/2013/05/22/smarter-navigation-to-the-beginning-of-a-line/
(defun smarter-move-beginning-of-line (arg)
   "Move point back to indentation of beginning of line.

Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line.
Effectively toggle between the first non-whitespace character and
the beginning of the line.

If ARG is not nil or 1, move forward ARG - 1 lines first.  If
point reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
       (let ((line-move-visual nil))
        (forward-line (1- arg))))
  (let ((orig-point (point)))
   (back-to-indentation)
   (when (= orig-point (point))
    (move-beginning-of-line 1))))
;; remap C-a to `smarter-move-beginning-of-line'
(global-set-key [remap move-beginning-of-line]
 'smarter-move-beginning-of-line)
;; }
;;----------------------------------------------------------------------
;; 删除整行
(global-set-key (kbd "C-'") 'kill-whole-line)
;; 注释掉整行
(global-set-key (kbd "M-'") 'whole-line-or-region-comment-dwim)
;; 为了切换拼音
(global-unset-key (kbd "C-SPC"))
;;----------------------------------------------------------------------



(require-package 'whitespace-cleanup-mode)
(global-whitespace-cleanup-mode t)

;; see http://www.emacswiki.org/emacs/TransientMarkMode
(transient-mark-mode 1)


;;-------------------------------------------------------------
;; Don't disable narrowing commands
;;-------------------------------------------------------------
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-defun 'disabled nil)

;;-------------------------------------------------------------
;; Show matching parens
;;-------------------------------------------------------------
(show-paren-mode 1)

;;-------------------------------------------------------------
;; Expand region
;;-------------------------------------------------------------
(require-package 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)


;;-------------------------------------------------------------
;; Don't disable case-change functions
;;-------------------------------------------------------------
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)


;;--------------------------------------------------------------
;; Rectangle selections, and overwrite text when the selection is active
;;--------------------------------------------------------------
(cua-selection-mode t)       ; for rectangles, CUA is nice


;;--------------------------------------------------------------
;; Handy key bindings
;;--------------------------------------------------------------
;; To be able to M-x without meta
(global-set-key (kbd "C-x C-m") 'execute-extended-command)

;; Vimmy alternatives to M-^ and C-u M-^
(global-set-key (kbd "C-j") 'join-line)
;;(global-set-key (kbd "C-c j") 'join-line)
;;(global-set-key (kbd "C-c J") (lambda () (interactive) (join-line 1)))

(global-set-key (kbd "C-;") 'set-mark-command)
(global-set-key (kbd "C-x C-.") 'pop-global-mark)

(global-set-key (kbd "RET") 'newline-and-indent)
;(global-set-key (kbd "C-j") 'newline)

(global-set-key (kbd "C-c c") 'comment-or-uncomment-region)
(global-set-key (kbd "C-c g") 'goto-line)
(global-set-key (kbd "C-o")
		(lambda ()
		  (interactive)
		  (move-end-of-line nil)
		  (newline-and-indent)))
(global-set-key (kbd "C-x 2") 'split-window-horizontally)
(global-set-key (kbd "C-x 3") 'split-window-vertically)

;; multiple-cursors
(require-package 'multiple-cursors)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "M-n") 'mc/mark-next-word-like-this)
(global-set-key (kbd "M-p") 'mc/mark-previous-word-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
;; From active region to multiple cursors:
(global-set-key (kbd "C-c m r") 'set-rectangular-region-anchor)
(global-set-key (kbd "C-c m c") 'mc/edit-lines)
(global-set-key (kbd "C-c m e") 'mc/edit-ends-of-lines)
(global-set-key (kbd "C-c m a") 'mc/edit-beginnings-of-lines)

(defun duplicate-region (beg end)
 "Insert a copy of the current region after the region."
 (interactive "r")
 (save-excursion
   (goto-char end)
   (insert (buffer-substring beg end))))

(defun duplicate-line-or-region (prefix)
 "Duplicate either the current line or any current region."
 (interactive "*p")
 (whole-line-or-region-call-with-region 'duplicate-region prefix t))

(global-set-key (kbd "C-c p") 'duplicate-line-or-region)


(defun kill-back-to-indentation ()
 "Kill from point back to the first non-whitespace character on the line."
 (interactive)
 (let ((prev-pos (point)))
   (back-to-indentation)
   (kill-region (point) prev-pos)))

(global-set-key (kbd "C-M-<backspace>") 'kill-back-to-indentation)


;;----------------------------------------------------------------
;; Shift lines up and down with M-up and M-down. When paredit is enabled,
;; it will use those keybindings. For this reason, you might prefer to
;; use M-S-up and M-S-down, which will work even in lisp modes.
;;----------------------------------------------------------------
(require-package 'move-text)
(move-text-default-bindings)
(global-set-key [M-S-up] 'move-text-up)
(global-set-key [M-S-down] 'move-text-down)


;;----------------------------------------------------------------
;; Cut/copy the current line if no region is active
;;----------------------------------------------------------------
(whole-line-or-region-mode t)
(diminish 'whole-line-or-region-mode)
(make-variable-buffer-local 'whole-line-or-region-mode)

(require-package 'highlight-escape-sequences)
(hes-mode)

(provide 'init-editing-utils)
;;; init-editing-utils ends here
