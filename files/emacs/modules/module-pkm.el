;;; module-pkm.el -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(use-package org-roam
  :custom
  (org-roam-directory (file-truename "~/doc/org/memex"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
	 ("C-c n f" . org-roam-node-find)
	 ("C-c n g" . org-roam-graph)
	 ("C-c n i" . org-roam-node-insert)
	 ("C-c n c" . org-roam-capture)
	 ;; Dailies
	 ("C-c n j" . org-roam-dailies-capture-today))
  :config
  (org-roam-db-autosync-mode))

(provide 'module-pkm)

;;; module-pkm.el ends here
