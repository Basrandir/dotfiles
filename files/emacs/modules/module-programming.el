;;; module-programming.el -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:
(use-package apheleia
  :config
  (add-to-list 'apheleia-mode-alist
	       '(tsx-ts-mode . prettier-typescript))
  (apheleia-global-mode +1))

(elpaca (tree-sitter-css-in-js
	 :host github
	 :repo "orzechowskid/tree-sitter-css-in-js")
  (require 'css-in-js-mode)
  (css-in-js-mode-fetch-shared-library t))

(provide 'module-programming)

;;; module-programming.el ends here
