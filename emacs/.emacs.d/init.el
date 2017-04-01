(package-initialize)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror t)

;; PACKAGE MANAGEMENT
(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")))

;; install use-package if not installed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package evil
  :ensure t
  :config
  (evil-mode t))

;; line numbers
(use-package nlinum
  :ensure t
  :config
  (use-package nlinum-relative
    :ensure t
    :config
    (nlinum-relative-setup-evil)
    (add-hook 'prog-mode-hook 'nlinum-relative-mode)
    (setq nlinum-relative-redisplay-delay 0))
  (add-hook 'prog-mode-hook 'nlinum-mode))

(use-package xresources-theme
  :ensure t
  :config
  (load-theme 'xresources t))

;; USER INTERFACE
;; show column number in modeline
(column-number-mode t)

;; remove clutter
(setq inhibit-splash-screen t
      inhibit-startup-message t
      inhibit-startup-echo-area-message t)
(menu-bar-mode -1)
(tool-bar-mode -1)

(when (boundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

;; BEHAVIOUR
;; automatically insert matching parens
(add-hook 'emacs-list-mode-hook (lambda () (electric-pair-mode -1)))
(electric-pair-mode 1)

;; highlight matching parens
(show-paren-mode t)

;; always follow symlinks
(setq vc-follow-symlinks t)

;; auto revert files on change
(global-auto-revert-mode t)

;; display current time
(display-time-mode t)

;; do no create backup files
(setq make-backup-files nil)
