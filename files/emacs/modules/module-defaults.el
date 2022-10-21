;;; module-defaults.el -*- lexical-binding: t;  -*-

;;; Commentary:

;;; Code:
;; Revert buffers if changed externally
(setq global-auto-revert-non-file-buffers t)
(global-auto-revert-mode 1)

;; Store all settings from Customization interface in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; Centralize backup files
(setq backup-directory-alist `(("." . ,(expand-file-name "backup" user-emacs-directory)))
      version-control t
      kept-new-version 10
      kept-old-versions 6)

;; Delete old backup files automatically
(setq delete-old-versions t)

;; Store autosave files in temp dir instead
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Put as many prompts in the minibuffer as possible (no popups)
(setq use-dialog-box nil)

;; Show column number in modeline
(column-number-mode t)

;; Highlight the line the cursor is on
(global-hl-line-mode t)

;; Change cursor to vertical line instead of bar
(setq-default cursor-type 'bar)

;; Display time and date in modeline but without system load average
(setq display-time-default-load-average nil)
(setq display-time-day-and-date t)
(display-time-mode t)

;; Auto save all buffers when frame loses focus
(add-hook 'focus-out-hook (lambda () (save-some-buffers t)))

;; Highlight matching parens
(setq show-paren-delay 0
      show-paren-when-point-inside-paren t)
(show-paren-mode t)

;; Replaces selcted text rather than ignoring it and inserting on cursor
(delete-selection-mode t)

;; Replace yes/no prompts with y/n
(fset 'yes-or-no-p 'y-or-n-p)

;; Enable Smooth Scrolling
(when (string-match-p (regexp-quote "29") emacs-version)
  (pixel-scroll-precision-mode))

;; Ace-window is a much better way of traversing Emacs windows once
;; you get more than 2.
(use-package ace-window
  :custom
  (aw-scope 'frame)
  :bind
  ("M-o" . ace-window))

(use-package avy
  :bind ("M-j" . avy-goto-char-timer))

(provide 'module-defaults)

;;; module-defaults.el ends here
