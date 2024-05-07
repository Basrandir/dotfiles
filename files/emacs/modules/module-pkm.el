;;; module-pkm.el -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:
(use-package denote
  :elpaca (denote :host github :repo "protesilaos/denote")
  :custom
  (denote-directory (expand-file-name "~/doc/org/memex"))
  (denote-journal-extras-title-format 'day-date-month-year)
  :bind (("C-c m f" . denote-open-or-create)))

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
  (advice-add 'denote :around #'my/denote-id-format-advice)
  (call-interactively 'denote-journal-extras-new-entry)
  (advice-remove 'denote #'my/denote-id-format-advice))

(defun my/denote-id-format-advice (orig-fun &rest args)
  (let ((denote-id-format "%Y%m%d")
	(denote-id-regexp "[0-9]\\{8\\}"))
    (apply orig-fun args)))

(defun my/denote-create-note-child ()
  "Create a new note with a signature that's a child to the current one."
  (interactive))

(provide 'module-pkm)

;;; module-pkm.el ends here
