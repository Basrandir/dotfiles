;;; module-ui.el -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

;;;; Theme
(use-package ef-themes
  :config
  (load-theme 'ef-cyprus t))

;; Tabs and ribbons for the mode line
(use-package moody
  :ensure t
  :config
  (setq x-underline-at-descent-line t)
  (moody-replace-mode-line-buffer-identification)
  (moody-replace-vc-mode)
  (moody-replace-eldoc-minibuffer-message-function))

;; Dashboard
(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  :custom
  (initial-buffer-choice (lambda () (get-buffer-create dashboard-buffer-name)))
  (dashboard-center-content t)
  (dashboard-startup-banner "~/media/images/wallpapers/headers/redwoods_by_robin_tran_960x353.png")
  (dashbaord-image-banner-max-width 950))

;; Enable rainbow-mode
(use-package rainbow-mode)

;; Set margins on all sides
(push '(internal-border-width . 16) default-frame-alist)

(provide 'module-ui)

;;; module-ui.el ends here
