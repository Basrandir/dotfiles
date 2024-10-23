;;; module-org.el -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(use-package org
  :hook
  (org-mode . org-indent-mode)
  (org-mode . (lambda ()
		"Beautify Org Src blocks"
		(push '("#+begin_src" . "λ") prettify-symbols-alist)
		(push '("#+end_src" . "λ") prettify-symbols-alist)
		(prettify-symbols-mode)))
  :bind (("C-c o l" . org-store-link)
	 ("C-c o a" . 'org-agenda-list)
	 ("C-c o c" . 'org-capture)
	 ("C-c o b" . 'org-iswitchb))
  :config
  ;; Enable Org habits
  (add-to-list 'org-modules 'org-habit t)

  (org-babel-do-load-languages
   'org-babel-load-languages
   '((shell . t)
     (python . t)))
  :custom
  ;; Follow (go to) links when clicking RET
  (org-return-follows-link t)

  ;; Elimate org magic removing empty lines between headings when
  ;; they're toggled closed
  (org-blank-before-new-entry '((heading . nil)
				(plain-list-item . nil)))
  (org-cycle-separator-lines 1)
  
  ;; Enabling displaying images by default
  (org-startup-with-inline-images t)

  ;; Remove / and * emphasis for italics and bold respectively
  (org-hide-emphasis-markers t)

  ;; Replace ... for hidden content with ⤵
  (org-ellipsis "⤵")
  
  ;; Org Agenda
  (setq org-agenda-files '("~/doc/org/routine.org"
			   "~/doc/org/personal.org"))
  
  ;; Set the default notes file where most captured tasks and ideas
  ;; will go to
  (org-default-notes-file "~/doc/org/inbox.org"))

;; org-tempo is a module that contains structure templates such as <s
;; that I use all the time.  As far as I'm aware, it used to be loaded
;; automatically with Org but now needs to be enabled manually.
(use-package org-tempo
  :after org)

(use-package org-timeblock
  :after org
  :custom
  (org-timeblock-span 7)
  (org-timeblock-inbox-file "/home/bassam/doc/org/routine.org")
  (org-timeblock-show-future-repeats t))

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

(use-package org-modern
  :after org
  :hook (org-mode . org-modern-mode))

;;;; Org Capture

(use-package org-capture
  :after org
  :custom
  (org-capture-templates
   `(("f" "Fleeting note" item
      (file+headline org-default-notes-file "Notes")
      "- %?")
     ("t" "New task" entry
      (file+headline org-default-notes-file "Tasks")
      "* TODO %i%?")
     ("w" "weight" table-line (file "~/doc/org/weight.org")
      "| %u | %? ||||")
     ("o" "org-protocol-capture" entry (file "~/doc/org/inbox.org")
      "* TODO [[%:link][%:description]]\n\n %i" :immediate-finish t))))

(use-package olivetti
  :hook
  ((org-mode elfeed-show-mode) . olivetti-mode))

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

(provide 'module-org)

;;; module-org.el ends here
