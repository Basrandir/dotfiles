;;; init.el --- Full configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Bootstraps configuration

;;; Code:

;; Bootstrap config
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; Bootstrap straight.el Package Manager
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Bootstrap use-package Package Configurator
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

;; Load configs
(require 'init-publish)

;; PACKAGES
(use-package which-key
  :config
  (which-key-mode))

(use-package all-the-icons)

(use-package srcery-theme
  :config
  (load-theme 'srcery t))

(use-package htmlize)

(use-package org-superstar
  :after org
  :hook (org-mode . org-superstar-mode))

(use-package rainbow-mode)

(use-package pdf-tools
  :config
  (pdf-tools-install)
  (setq-default pdf-view-display-size 'fit-page)
  (setq pdf-annot-activate-created-annotations t)
  :bind (:map pdf-view-mode-map
	      ("i" . pdf-view-midnight-minor-mode)
	      ("c" . pdf-annot-add-text-annotation)))

(use-package magit
  :bind (("C-x g" . magit-status)))

(use-package company
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-life 3)
  :hook
  ((prog-mode ledger-mode) . company-mode))

(use-package flycheck
  :commands flycheck-mode)

(use-package projectile
  :config
  (projectile-mode +1)
  :custom
  (projectile-completion-system 'ivy)
  :bind (:map projectile-mode-map
	      ("C-x p" . projectile-command-map)))

(use-package visual-fill-column)

(use-package telega
  :init
  (add-hook 'telega-chat-mode-hook
	    (lambda ()
	      (set (make-local-variable 'comapny-backends)
		   (append '(telega-company-emoji
			     telega-company-username
			     telega-company-hashtag)
			   (when (telega-chat-bot-p telega-chatbuf--chat)
			     '(telega-company-botcmd))))
	      (company-mode 1)))
  :commands (telega)
  :config
  (telega-notifications-mode 1)
  :defer t)

(use-package dired
  :straight nil
  :config
  ;; Human readable file sizes
  (setq dired-listing-switches "-lha")
  
  ;; Colourful columns
  (use-package diredfl
    :config
    (diredfl-global-mode 1)))

(use-package ace-window
  :bind
  ("M-o" . ace-window)
  ([remap other-window] . ace-window))

(use-package webfeeder)

(use-package counsel
  :init (ivy-mode 1)
  :config
  (setq ivy-use-virtual-buffers t)
  (setq ivy-height 20)
  (setq ivy-count-format "%d/%d ")
  (setq counsel-find-file-at-point t)
  (setq ivy-use-selectable-prompt t))

(use-package elfeed
  :bind
  ("C-x w" . elfeed))

(use-package elfeed-org
  :after elfeed
  :config
  (elfeed-org))

(use-package elfeed-goodies
  :after elfeed
  :config
  (elfeed-goodies/setup))

(use-package elfeed-protocol
  :after elfeed)
  
(use-package deft
  :after org
  :bind ("C-c n d" . deft)
  :commands (deft)
  :config
  (setq deft-directory "~/doc/notes")
  (setq deft-recursive t)
  (setq deft-default-extension "org")
  (setq deft-use-filename-as-title t)
  (setq deft-use-filter-string-for-filename t))

(use-package bufler)

(use-package vterm
  :config
  (setq vterm-shell "/usr/bin/fish")
  :hook (vterm-mode . (lambda ()
                        (setq-local global-hl-line-mode nil))))

(use-package realgud
  :commands
  (realgud:pdb))

(use-package org-protocol
  :straight nil)

(use-package olivetti
  :hook
  (olivetti-mode . variable-pitch-mode))

(use-package org-roam
  :config
  (setq org-roam-directory "~/doc/notes/")
  :bind (:map org-roam-mode-map
	      (("C-c n l" . org-roam)
	       ("C-c n f" . org-roam-find-file))
	      :map org-mode-map
	      (("C-c n i" . org-roam-insert))
	      (("C-c n I" . org-roam-insert-immediate))))

(use-package emms
  :config
  (require 'emms-setup)
  (require 'emms-player-mpd)
  (emms-all)
  :custom
  (emms-player-list '(emms-player-mpd))
  (emms-info-functions '(emms-info-mpd))
  (emms-player-mpd-server-name "localhost")
  (emms-player-mpd-server-port "6600")
  :bind
  ("C-c m e" . emms)
  ("C-c m b" . emms-smart-browse)
  ("C-c m r" . emms-player-mpd-update-all-reset-cache))

(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-;")
  :hook
  ((python-mode . lsp)
   (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

(use-package lsp-ui
  :after lsp-mode
  :commands lsp-ui-mode)

(use-package lsp-ivy
  :after lsp-mode
  :commands lsp-ivy-workspace-symbol)

(use-package ledger-mode
  :config
  (setq ledger-clear-whole-transactions t
	ledger-default-date-format ledger-iso-date-format)
  :mode
  ("\\.dat\\'"))

;; UI

;; Hide splash page
(setq inhibit-startup-message t)

;; Show column number in modeline
(column-number-mode t)

;; Highlight the line the cursor is on
(global-hl-line-mode t)

;; Sane scrolling
(setq scroll-conservatively 101)

;; Change cursor to vertical line
(setq-default cursor-type 'bar)

(use-package org
  :straight nil
  :config
  (dolist (org-headings org-level-faces)
    (set-face-attribute org-headings nil :family "B612")))

;; Auto save all buffers when frame loses focus
(add-hook 'focus-out-hook (lambda () (save-some-buffers t)))

;; Centralize backup files
(setq backup-directory-alist `(("." . ,(expand-file-name "backup" user-emacs-directory)))
      version-control t
      kept-new-version 10
      kept-old-versions 6)

;; Store autosave files in temp dir instead
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Delete old backup files automatically
(setq delete-old-versions t)

;; Highlight matching parens
(setq show-paren-delay 0
      show-paren-when-point-inside-paren t)
(show-paren-mode t)

;; Show time in modeline
(display-time-mode t)

;; Replaces selcted text rather than ignoring it and inserting on cursor
(delete-selection-mode t)

;; Hide the cursor in inactive windows
(setq cursor-in-non-selected-windows t)

;; Replace yes/no prompts with y/n
(fset 'yes-or-no-p 'y-or-n-p)

;; Ido-mode
;(setq ido-enable-flex-matching t)
;(setq ido-everywhere t)
;(setq ido-use-filename-at-point 'guess)
;(ido-mode 1)

;; Use ibuffer
(defalias 'list-buffers 'ibuffer)

;; Async Shell commands
(setq-default async-shell-command-display-buffer nil
	      async-shell-command-buffer 'new-buffer)

;; ORG-MODE

;; Elimate org magic removing empty lines between headings when they're toggled closed
(setq org-blank-before-new-entry '((heading . nil)
				   (plain-list-item . nil)))
(setq org-cycle-separator-lines 1)

;; Enabling displaying images by default
(setq org-startup-with-inline-images t)

;; Start spellchecker for every org buffer
(add-hook 'org-mode-hook 'turn-on-flyspell)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((shell . t)
   (python . t)))

;; Set org-agenda files
(setq org-agenda-files (quote ("~/doc/agenda/")))

;; Org Capture
(setq org-capture-templates
      `(("i" "inbox" entry (file "~/doc/agenda/inbox.org")
	 "* TODO %?")
	("c" "org-protocol-capture" entry (file "~/doc/agenda/inbox.org")
	 "* TODO [[%:link][%:description]]\n\n %i" :immediate-finish t)
	("p" "org-protocol-projects" entry (file "~/doc/notes/Projects.org")
	 "* TODO [[%:link][%:description]]\n\n %i" :immediate-finish t)))

;; Closing items
(setq org-log-done 'note)

;; Remove / and * emphasis for italics and bold respectively
(setq org-hide-emphasis-markers t)

;; Replace ... for hidden content with ⤵
(setq org-ellipsis "⤵")

;; - List replaced with •
(font-lock-add-keywords 'org-mode
			'(("^ *\\([-]\\) "
			   (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

;; Keybindings
(define-key global-map (kbd "C-c o l") 'org-store-link)
(define-key global-map (kbd "C-c o a") 'org-agenda-list)
(define-key global-map (kbd "C-c o c") 'org-capture)
(define-key global-map (kbd "C-c o b") 'org-iswitchb)

;; HTML5 export
(setq org-html-html5-fancy t)

;; Differentiate between URL links and other links
;;(org-link-set-parameters "http" :face '(:box t))
;;(org-link-set-parameters "https" :face '(:box t))

(defun org-link-make-external-string (orig-fun link description)
  "Add external link icon in DESCRIPTION when LINK is http(s).
Then call ORIG-FUN."
  (if (or (string= (url-type (url-generic-parse-url link)) "http")
	  (string= (url-type (url-generic-parse-url link)) "https"))
      (setq description (concat "  " description)))
  (apply orig-fun (list link description)))

;; All external links have icon appended to them
(advice-add 'org-link-make-string :around #'org-link-make-external-string)

;; Enable auto-fill mode (limit M-q)
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; PROGRAMMING

;; Python
(use-package python
  :bind (:map python-mode-map
	      ("M-n" . python-nav-forward-block)
	      ("M-p" . python-nav-backward-block)
	      ("C-c i r" . python-indent-shift-right)
	      ("C-c i l" . python-indent-shift-left)))

(use-package poetry)

;; WEBSITE


(provide 'init)
;;; init.el ends here
