;;; module-ui.el -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

;;;; Theme

(use-package catppuccin-theme
  :elpaca t
  :config
  (load-theme 'catppuccin t))

;; Tabs and ribbons for the mode line
(use-package moody
  :elpaca t
  :config
  (setq x-underline-at-descent-line t)
  (moody-replace-mode-line-buffer-identification)
  (moody-replace-vc-mode)
  (moody-replace-eldoc-minibuffer-message-function))

;; Enable rainbow-mode
(use-package rainbow-mode)

(provide 'module-ui)

;;; module-ui.el ends here
