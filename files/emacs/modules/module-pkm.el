;;; module-pkm.el -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:
(use-package denote
  :elpaca (denote :host sourcehut
		  :repo "protesilaos/denote")
  :custom
  (denote-directory (expand-file-name "~/doc/org/memex"))
  :config
  (defun my-denote-journal ()
    "Create an entry tagged 'journal' with the date as its title."
    (interactive)
    (denote
     (format-time-string "%A %e %B %Y") ; format like Tuesday 14 July 2022
     '("journal"))) ; multiple keywords are a list of strings: '("one" "two")
  :bind (("C-c m f" . denote-open-or-create)))

(provide 'module-pkm)

;;; module-pkm.el ends here
