;;; module-dired.dl -*- lexical-binding: t; -*-

;;; Commentary:


;;; Code:
(use-package dired
  :bind (:map dired-mode-map
	      ;; by default the binding for mouse-2 is
	      ;; 'dired-mouse-find-file-other-window
	      ([mouse-2] . 'dired-mouse-find-file))
  :custom
  ;; Human readable file sizes
  (dired-listing-switches "-lha --group-directories-first")
  ;; Stops the proliferation of dired buffers
  (dired-kill-when-opening-new-dired-buffer t))

(use-package diredfl
  :after dired
  :config
  (diredfl-global-mode 1))

(provide 'module-dired)

;;; module-dired.el ends here
