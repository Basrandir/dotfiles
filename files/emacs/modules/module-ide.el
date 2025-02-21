;;; module-ide.el -*- lexical-binding: t; -*-

;;; Commentary:

;; This file contains the configuration for an IDE setup. The purpose
;; of this module is to enhance Emacs and transform it into a powerful
;; Integrated Development Environment. It achieves this by integrating
;; and configuring various packages (internal and external) for syntax
;; highlighting, formatting, code completion, project management, and
;; language servecs.

;;; Code:
(use-package apheleia
  :config
  (add-to-list 'apheleia-formatters '(rustfmt . ("rustfmt" "--quiet" "--emit" "stdout" "--edition" "2021")))
  (add-to-list 'apheleia-mode-alist
	       '(tsx-ts-mode . prettier-typescript))
  (apheleia-global-mode +1))

;; Documentation
(use-package eldoc-box
  :ensure t
  :config
  (set-face-attribute 'eldoc-box-border nil :background "white"))

;; Tree-sitter
(use-package treesit
  :custom
  (treesit-font-lock-level 4))

(use-package treesit-auto
  :ensure t
  :custom
  (treesit-auto-install 'prompt)
  :config
  (global-treesit-auto-mode))

;; Eglot
(use-package eglot
  :bind (:map eglot-mode-map
	      ("C-c e" . eglot-code-actions)
	      ("M-h" . eldoc-box-help-at-point))
  ;; :hook (eglot--managed-mode . limit-eldoc-to-single-line)
  :init
  (defun limit-eldoc-to-single-line ()
    "Limit Eldoc output to a single line in the echo area."
    (setq-local eldoc-echo-area-use-multiline-p nil)))

;; Rust
(use-package rust-ts-mode
  :mode ("\\.rs" . rust-ts-mode)
  :hook (rust-ts-mode . eglot-ensure)
  :bind (:map rust-ts-mode-map
	      ("C-c C-c C-u" . rust-compile)
	      ("C-c C-c C-k" . rust-check)
	      ("C-c C-c C-t" . rust-test)
	      ("C-c C-c C-r" . rust-run)))

(use-package tsx-ts-mode
  :mode "\\.tsx\\'")

(use-package envrc
  :after eglot
  :config
  (envrc-global-mode))

(provide 'module-ide)

;;; module-ide.el ends here
