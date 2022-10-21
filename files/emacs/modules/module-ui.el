;;; module-ui.el -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

;;;; Theme

(use-package catppuccin-theme
  :straight t)

(load-theme 'catppuccin-mocha t)

;; Flash the line the cursor is on when moving
;; taken from https://karthinks.com/software/batteries-included-with-emacs
(defun pulse-line (&rest _)
  "Pulse the current line."
  (pulse-momentary-highlight-one-line (point)))

(dolist (command '(scroll-up-command scroll-down-command
				     recenter-top-bottom other-window))
  (advice-add command :after #'pulse-line))

(provide 'module-ui)

;;; module-ui.el ends here
