;;; module-pkm.el -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:
(use-package denote
  :elpaca (denote :host sourcehut :repo "protesilaos/denote")
  :custom
  (denote-directory (expand-file-name "~/doc/org/memex"))
  (denote-journal-extras-title-format 'day-date-month-year)
  :config
  (defun my/denote-files-created ()
    "Return a list of denote files created on the same day as the
creation date of the file this function is called from."
    (let* ((filename (buffer-file-name))
	   (date-substring (when (string-match "\\([0-9]\\{8\\}\\)" filename)
			     (match-string 0 filename)))
	   (files (denote-directory-files-matching-regexp))
	   (org-list ""))
      (dolist (file files org-list)
	(setq org-list (concat org-list "- [[denote:" (denote-retrieve-filename-identifier file) "][" (denote-retrieve-title-value file 'org) "]]\n")))
      org-list))

  (defun my/denote-files-modified ()
    "Return a list of denote files modified on the same day as the
creation date of the file this function is called from."
    (let* ((filename (buffer-file-name))
	   (date-substring (when (string-match "\\([0-9]\\{8\\}\\)" filename)
			     (match-string 0 filename)))
	   (files-modified '())
	   (org-list ""))
      (dolist (file (denote-directory-files))
	(when (and (file-regular-p file)
		   (string= date-substring (format-time-string "%Y%m%d" (nth 5 (file-attributes filename)))))
	  (push file files-modified)))
      (dolist (file files-modified org-list)
	(setq org-list (concat org-list "- [[denote:" (denote-retrieve-filename-identifier file) "][" (denote-retrieve-title-value file 'org) "]]\n")))
      org-list))
  
  (defun my/denote-journal ()
    "Create an entry tagged 'journal' with the date as its title."
    (interactive)
    (let ((denote-id-format "%Y%m%d"))
      (denote-journal-extras-new-entry)))
  :bind (("C-c m f" . denote-open-or-create)))

(provide 'module-pkm)

;;; module-pkm.el ends here
