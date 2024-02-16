;;; module-typst.el -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:
(use-package typst-ts-mode
  :elpaca (:type git :host sourcehut :repo "meow_king/typst-ts-mode")
  :custom
  (typst-ts-mode-watch-options "--open")
  (typst-ts-mode-enable-raw-blocks-highlight t)
  (typst-ts-mode-highlight-raw-blocks-at-startup t))

(provide 'module-typst)

;;; module-typst.el ends here
