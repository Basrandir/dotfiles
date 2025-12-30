;;; module-stream.el -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(defvar my/font-size-toggle-state nil
  "Tracks the font size toggle state. If nil, font size is normal. If t, font size is doubled.")

(defvar my/original-font-size (face-attribute 'default :height)
  "Stores the original font size before toggling.")

(defun my/toggle-font-size ()
  "Toggle font size between normal and double its normal size."
  (interactive)
  (if my/font-size-toggle-state
      (progn
        (set-face-attribute 'default nil :height my/original-font-size)
	(setq my/font-size-toggle-state nil)
	(message "Font size set to normal."))
    ;; Double the font size
    (set-face-attribute 'default nil :height (* 2 my/original-font-size))
    (setq my/font-size-toggle-state t)
    (message "Font size doubled.")))

(provide 'module-stream)

;;; module-stream.el ends here
