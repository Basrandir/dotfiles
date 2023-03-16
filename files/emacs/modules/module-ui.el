;;; module-ui.el -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

;;;; Theme

(elpaca catppuccin-theme
  (load-theme 'catppuccin t))

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
