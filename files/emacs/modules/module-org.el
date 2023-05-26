;;; module-org.el -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

;; org-tempo is a module that contains structure templates such as <s that I use all the time.
;; As far as I'm aware, it used to be loaded automatically with Org but now needs to be enabled manually.
(use-package org-tempo
  :after org)

;; Beautify Org Src blocks
(add-hook 'org-mode-hook (lambda ()
			   "Beautify Org Src blocks"
			   (push '("#+begin_src" . "λ") prettify-symbols-alist)
			   (push '("#+end_src" . "λ") prettify-symbols-alist)
			   (prettify-symbols-mode)))

;; Follow (go to) links when clicking RET
(setq org-return-follows-link t)

;; Elimate org magic removing empty lines between headings when they're toggled closed
(setq org-blank-before-new-entry '((heading . nil)
				   (plain-list-item . nil)))
(setq org-cycle-separator-lines 1)

;; Enabling displaying images by default
(setq org-startup-with-inline-images t)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((shell . t)
   (python . t)))

;; Remove / and * emphasis for italics and bold respectively
(setq org-hide-emphasis-markers t)

;; While hiding emphasis markers is great, editing them can be
;; slightly annoying in that situation. Org-appear allows these
;; emphasis markers to show automaticallly when the cursor is placed
;; inside.
(use-package org-appear
  :hook (org-mode . org-appear-mode)
  :custom
  ;; applies same functionality of making invisible elements appear
  ;; visible to links as well
  (org-appear-autolinks t))

;; Replace ... for hidden content with ⤵
(setq org-ellipsis "⤵")

;; Enable auto-fill mode (limit M-q)
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; General Org Keybindings
(define-key global-map (kbd "C-c o l") 'org-store-link)
(define-key global-map (kbd "C-c o a") 'org-agenda-list)
(define-key global-map (kbd "C-c o c") 'org-capture)
(define-key global-map (kbd "C-c o b") 'org-iswitchb)

(use-package org-modern
  :after org
  :hook (org-mode . org-modern-mode))

;;;; Org Capture
(setq org-capture-templates
      `(("c" "capture" entry (file "~/doc/org/inbox.org")
	 "* TODO %?")
	("w" "weight" table-line (file "~/doc/org/weight.org")
	 "| %u | %? ||||")
	("o" "org-protocol-capture" entry (file "~/doc/org/inbox.org")
	 "* TODO [[%:link][%:description]]\n\n %i" :immediate-finish t)))

;; Inspired by this thread:
;; https://old.reddit.com/r/emacs/comments/74gkeq/system_wide_org_capture/
;; the following code allows for the creation of a one-time use
;; org-capture frame which can be triggered with the following command:
;; emacsclient -c -F '(quote (name . "capture"))' -e '(activate-capture-frame)'
(defun activate-capture-frame ()
  "run org-capture in capture frame"
  (select-frame-by-name "capture")
  (org-capture))

(defun supress-window-splitting (&rest _)
  "Delete the extra window if we're in a capture frame"
  (if (equal "capture" (frame-parameter nil 'name))
      (delete-other-windows)))

(defun delete-capture-frame (&rest _)
  "Advise capture-finalize to close the frame"
  (when (and (equal "capture" (frame-parameter nil 'name))
	     (not (eq this-command 'org-capture-refile)))
    (delete-frame)))

(advice-add 'org-switch-to-buffer-other-window :after #'supress-window-splitting)
(advice-add 'org-capture-finalize :after #'delete-capture-frame)

;; Org Agenda
(setq org-agenda-files '("~/doc/org/routine.org"))

;; Org habits
(add-to-list 'org-modules 'org-habit t)

(provide 'module-org)

;;; module-org.el ends here
