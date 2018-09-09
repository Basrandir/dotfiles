(setq inhibit-startup-message t)

(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
(when (fboundp 'horizontal-scroll-bar-mode)
  (horizontal-scroll-bar-mode -1))

(fboundp 'horizontal-scroll-bar-mode)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

;; Bootstrap 'use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package which-key
  :ensure t
  :config (which-key-mode))

;; Themes
(use-package poet-theme
  :ensure t
  :init
  (set-face-attribute 'default nil :family "Iosevka" :height 130)
  (set-face-attribute 'fixed-pitch nil :family "Iosevka")
  (set-face-attribute 'variable-pitch nil :family "Libre Baskerville")
  :config
  (add-hook 'text-mode-hook
	    (lambda ()
	      (variable-pitch-mode 1))))

;; Org-Mode
(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook
	    (lambda ()
	      (org-bullets-mode 1))))

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)

(setq org-agenda-files (quote ("~/doc/org/jobapplications.org")))

;; User Interface

;; Enable line numbers for all programming modes
;;(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; Automatically Added

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (poet-theme org-bullets which-key use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
