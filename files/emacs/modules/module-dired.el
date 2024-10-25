;;; module-dired.dl -*- lexical-binding: t; -*-

;;; Commentary:


;;; Code:
(use-package dired
  :bind (:map dired-mode-map
	      ("C-c o" . 'dired-open-file)
	      ("C-c d" . 'dired-dotfiles-toggle)
	      ;; by default the binding for mouse-2 is
	      ;; 'dired-mouse-find-file-other-window
	      ([mouse-2] . 'dired-mouse-find-file))
  :custom
  ;; Human readable file sizes
  (dired-listing-switches "-lha --group-directories-first")
  ;; Stops the proliferation of dired buffers
  (dired-kill-when-opening-new-dired-buffer t)
  :init
  (defun dired-open-file ()
    "Open current file in default application."
    (interactive)
    (start-process "xdg-open-in-dired" nil "xdg-open" (dired-get-filename)))

  ;; Taken from https://www.emacswiki.org/emacs/DiredOmitMode
  (defun dired-dotfiles-toggle ()
    "Show/hide dot-files"
    (interactive)
    (when (equal major-mode 'dired-mode)
      (if (or (not (boundp 'dired-dotfiles-show-p)) dired-dotfiles-show-p) ; if currently showing
	  (progn 
	    (set (make-local-variable 'dired-dotfiles-show-p) nil)
	    (message "h")
	    (dired-mark-files-regexp "^\\\.")
	    (dired-do-kill-lines))
	(progn (revert-buffer) ; otherwise just revert to re-show
	       (set (make-local-variable 'dired-dotfiles-show-p) t))))))

;; Setup through Denote config
(use-package diredfl
  :after dired)

(provide 'module-dired)


;;; module-dired.el ends here
