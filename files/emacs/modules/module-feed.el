;;; module-feed.el -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:
(use-package elfeed
  :bind (("C-x w" . elfeed)
	 :map elfeed-search-mode-map
	 ("F" . elfeed-update)))

(use-package elfeed-org
  :after elfeed
  :custom
  (rmh-elfeed-org-files (list "~/.config/emacs/elfeed.org"))
  :config
  (elfeed-org))

;; For use with external feed readers like TinyRSS
(use-package elfeed-protocol
  :after elfeed)

(use-package elfeed-tube
  :ensure t
  :config
  (elfeed-tube-setup))

(use-package elfeed-tube-mpv
  :ensure t
  :bind (:map elfeed-show-mode-map
              ("C-c C-f" . elfeed-tube-mpv-follow-mode)
              ("C-c C-w" . elfeed-tube-mpv-where)))

(provide 'module-feed)

;;; module-feed.el ends here
