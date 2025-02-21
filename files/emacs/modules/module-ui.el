;;; module-ui.el -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

;;;; Theme
(use-package kanagawa-themes
  :ensure t
  :config
  (load-theme 'kanagawa-dragon t)
  (set-face-attribute 'vertico-posframe-border nil :background "#54546D"))

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
  (dashboard-banner-logo-title nil)
  (dashboard-startup-banner "~/media/images/wallpapers/headers/redwoods_by_robin_tran_960x353.png")
  (dashbaord-image-banner-max-width 950))

;; Enable rainbow-mode
(use-package rainbow-mode)

;; Enable Nerd Icons
(use-package nerd-icons
  :ensure t)

(use-package nerd-icons-dired
  :ensure t
  :after (dired nerd-icons)
  :hook (dired-mode . nerd-icons-dired-mode))

(use-package nerd-icons-completion
  :ensure t
  :after (vertico nerd-icons)
  :config
  (nerd-icons-completion-mode))

(use-package nerd-icons-corfu
  :ensure t
  :after (corfu nerd-icons)
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

;; Set margins on all sides
(push '(internal-border-width . 16) default-frame-alist)

(provide 'module-ui)

;;; module-ui.el ends here
