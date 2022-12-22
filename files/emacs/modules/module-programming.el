;;; module-programming.el -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:
(use-package apheleia
  :config
  (add-to-list 'apheleia-mode-alist
	       '(tsx-ts-mode . prettier-typescript))
  (apheleia-global-mode +1))

(use-package css-in-js-mode
  :straight
  '(css-in-js-mode :type git :host github :repo "orzechowskid/tree-sitter-css-in-js" :branch "main" :post-build
                   ((require 'css-in-js-mode) (css-in-js-mode-fetch-shared-library t))))

(provide 'module-programming)

;;; module-programming.el ends here
