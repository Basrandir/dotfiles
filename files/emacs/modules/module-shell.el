;;; module-shell.el -*- lexical-binding: t;  -*-

;;; Commentary:

;;; Code:

;; An alternative Emacs terminal built on top libvterm. Need to figure
;; out a way to automate colours.
(use-package vterm
  :custom
  (vterm-shell "/home/bassam/.guix-home/profile/bin/fish")
  :hook (vterm-mode . (lambda ()
			(setq-local global-hl-line-mode nil))))

(provide 'module-shell)

;;; module-shell.el ends here
