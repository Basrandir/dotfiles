;;; module-lsp.el -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :custom (lsp-keymap-prefix "C-c l"))

(use-package lsp-ui
  :after lsp-mode
  :commands lsp-ui-mode
  :custom
  (lsp-ui-peek-always-show t)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-doc-position 'at-point)
  (lsp-eldoc-render-all t)
  :hook
  (lsp-mode . lsp-ui-mode))

(use-package lsp-java
  :after lsp-mode
  :config
  (add-hook 'java-mode-hook #'lsp-deferred))

(use-package dap-mode
  :after lsp-mode
  :config
  (dap-auto-configure-mode))

(use-package dap-java)

(use-package envrc
  :after lsp-mode
  :config
  (envrc-global-mode))

(provide 'module-lsp)

;;; module-lsp.el ends here
