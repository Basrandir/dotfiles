;;; init.el --- For Emacs 28. -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:
;; Profile emacs startup
(add-hook 'emacs-startup-hook
	  (lambda ()
	    (message "Emacs loaded in %s."
		     (format "%.2f seconds"
			     (float-time
			      (time-subtract after-init-time before-init-time))))))

;; Initialize straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Add custom modules folder to load path
(add-to-list 'load-path (expand-file-name "modules" user-emacs-directory))

;; Require Modules
(require 'module-completion)
(require 'module-defaults)
(require 'module-dired)
(require 'module-lsp)
(require 'module-org)
(require 'module-pkm)
(require 'module-shell)
(require 'module-ui)
(require 'module-programming)

;; Set margins on all sides
(push '(internal-border-width . 16) default-frame-alist)

;; Telega - Telegram client
;; (use-package visual-fill-column)
(use-package telega
  :after visual-fill-column
  :commands (telega)
  :config
  (telega-notifications-mode 1)
  (add-hook 'telega-chat-mode-hook
	      (set (make-local-variable 'comapny-backends)
		   (append '(telega-company-emoji
			     telega-company-username
			     telega-company-hashtag)
			   (when (telega-chat-bot-p telega-chatbuf--chat)
			     '(telega-company-botcmd))))))

;; Make GC pauses faster.
(setq gc-cons-threshold (* 2 1000 1000))

(provide 'init)

;;; init.el ends here
