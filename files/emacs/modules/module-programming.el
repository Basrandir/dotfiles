;;; module-programming.el -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:
(use-package apheleia
  :config
  (add-to-list 'apheleia-mode-alist
	       '(tsx-ts-mode . prettier-typescript))
  (apheleia-global-mode +1))

;; Tree-sitter
(use-package treesit-auto
  :elpaca t
  :custom
  (treesit-auto-install 'prompt)
  :config
  (global-treesit-auto-mode))

(provide 'module-programming)

;;; module-programming.el ends here
