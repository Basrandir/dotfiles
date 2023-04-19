;;; module-templates.el -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

;; Configure Tempel
(use-package tempel
  :bind (("M-+" . tempel-complete) ;; Alternative tempel-expand
         ("M-*" . tempel-insert)))

(provide 'module-templates)

;;; module-templates.el ends here
